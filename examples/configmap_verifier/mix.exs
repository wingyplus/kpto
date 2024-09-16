defmodule ConfigmapVerifier.MixProject do
  use Mix.Project

  def project do
    [
      app: :configmap_verifier,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ConfigmapVerifier.Application, []}
    ]
  end

  defp releases do
    [
      configmap_verifier: [
        steps: [:assemble, &Burrito.wrap/1],
        burrito: [
          targets: [
            macos_x86_64: [os: :darwin, cpu: :x86_64],
            macos_arm64: [os: :darwin, cpu: :aarch64],
            linux_x86_64: [os: :linux, cpu: :x86_64],
            linux_arm64: [os: :linux, cpu: :aarch64],
          ]
        ],
        include_executables_for: [:unix]
      ]
    ]
  end

  defp deps do
    [
      {:burrito, "~> 1.0"},
      {:kpto, [path: "../../kpto", override: true]},
      {:igniter, "~> 0.3", only: :dev, runtime: false}
    ]
  end
end
