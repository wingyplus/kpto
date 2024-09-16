defmodule ConfigmapVerifier.Application do
  use Application

  @impl true
  def start(_, _) do
    Application.ensure_all_started(:yamerl)

    ConfigmapVerifier
    |> Kpto.Fn.run()
    |> IO.puts()

    System.halt(0)
  end
end
