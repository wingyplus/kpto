defmodule ConfigmapVerifier do
  @moduledoc """
  Dagger module for configmap_verifier.
  """

  use Dagger.Mod.Object, name: "ConfigmapVerifier"

  @doc """
  Build a container.
  """
  defn build(
         dir:
           {Dagger.Directory.t() | nil,
            default_path: "../..",
            ignore: [
              "**/*",
              "!**/lib/**/*.ex",
              "!**/mix.exs",
              "!**/mix.lock",
              "**/deps",
              "**/_build"
            ]}
       ) ::
         Dagger.Container.t() do
    {:ok, target} =
      dag()
      |> Dagger.Client.default_platform()

    target =
      platform_to_release_target(target)

    bin =
      dag()
      |> Dagger.Client.container()
      |> Dagger.Container.from("hexpm/elixir:1.17.2-erlang-27.0.1-alpine-3.20.3")
      |> Dagger.Container.with_env_variable("BURRITO_TARGET", target)
      |> Dagger.Container.with_env_variable("MIX_ENV", "prod")
      |> Dagger.Container.with_env_variable("MIX_HOME", "/.mix")
      |> Dagger.Container.with_env_variable("PATH", "$MIX_HOME/escripts:/zig:$PATH", expand: true)
      |> Dagger.Container.with_workdir("/kpto/examples/configmap_verifier")
      |> Dagger.Container.with_mounted_directory("/zig", zig(dag(), "0.13.0"))
      |> Dagger.Container.with_exec(~w"apk add xz")
      |> Dagger.Container.with_exec(~w"mix local.hex --force")
      |> Dagger.Container.with_exec(~w"mix local.rebar --force")
      |> Dagger.Container.with_mounted_directory("/kpto", dir)
      |> Dagger.Container.with_exec(~w"mix deps.get --only prod")
      |> Dagger.Container.with_exec(~w"mix release --force")
      |> Dagger.Container.file("burrito_out/configmap_verifier_#{target}")

    dag()
    |> Dagger.Client.container()
    |> Dagger.Container.from("cgr.dev/chainguard/wolfi-base")
    |> Dagger.Container.with_env_variable(
      "CONFIGMAP_VERIFIER_INSTALL_DIR",
      "/home/nobody/.burrito"
    )
    |> Dagger.Container.with_directory("/home/nobody", dag() |> Dagger.Client.directory(),
      owner: "nobody:nobody"
    )
    |> Dagger.Container.with_new_file(
      "/usr/local/bin/function-wrapper",
      """
      #!/bin/sh

      # HACK: prevent log printing from burrito.
      /usr/local/bin/function $@ | grep -v '^\\[i\\]'
      """,
      permissions: 0o755,
      owner: "nobody:nobody"
    )
    |> Dagger.Container.with_file("/usr/local/bin/function", bin, owner: "nobody:nobody")
    |> Dagger.Container.with_user("nobody")
    |> Dagger.Container.with_entrypoint(["/usr/local/bin/function-wrapper"])
  end

  defp zig(dag, version) do
    compiler =
      dag
      |> Dagger.Client.http(
        "https://ziglang.org/download/#{version}/zig-linux-aarch64-#{version}.tar.xz"
      )

    dag
    |> Dagger.Client.container()
    |> Dagger.Container.from("cgr.dev/chainguard/wolfi-base")
    |> Dagger.Container.with_file("/zig.tar.xz", compiler)
    |> Dagger.Container.with_exec(~w"apk add xz")
    |> Dagger.Container.with_exec(~w"tar xvf /zig.tar.xz")
    |> Dagger.Container.with_exec(~w"mv zig-linux-aarch64-#{version} zig")
    |> Dagger.Container.directory("/zig")
  end

  defp platform_to_release_target(platform) do
    [os, arch] = String.split(platform, "/")
    "#{os}_#{arch}"
  end
end
