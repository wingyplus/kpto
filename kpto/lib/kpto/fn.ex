defmodule Kpto.Fn do
  @moduledoc """
  The behaviour and entrypoint of the Kpt function.
  """

  @callback run(Kpto.Api.KRM.V1.ResourceList.t()) :: Kpto.Api.KRM.V1.ResourceList.t()

  def run(module) when is_atom(module) do
    run(module, IO.read(:stdio, :eof))
  end

  def run(module, input) when is_atom(module) and is_binary(input) do
    input
    |> Kpto.YAML.decode(Kpto.Api.KRM.V1.ResourceList)
    |> module.run()
    |> Kpto.YAML.encode()
  end
end
