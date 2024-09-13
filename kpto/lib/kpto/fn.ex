defmodule Kpto.Fn do
  @moduledoc """
  The behaviour and entrypoint of the Kpt function.
  """

  @callback run(Kpto.Api.KRM.ResourceList.t()) :: Kpto.Api.KRM.ResourceList.t()

  def run(module) when is_atom(module) do
    run(module, IO.read(:stdin, :eof))
  end

  def run(module, input) do
  end
end
