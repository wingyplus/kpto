defmodule Kpto.MixProject do
  use Mix.Project

  def project do
    [
      app: :kpto,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:yaml_elixir, "~> 2.11"},
      {:ymlr, "~> 5.1"}
    ]
  end
end
