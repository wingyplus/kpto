# This code generated by `mix kpt.codegen`. PLEASE DO NOT EDIT.
defmodule Kpto.Api.KRM.V1.ResourceList do
  @moduledoc """
  ResourceList is the input/output wire format for KRM functions.
  """

  @type t() :: %__MODULE__{
          api_version: String.t(),
          function_config: map(),
          items: [map()],
          kind: String.t(),
          results: [Kpto.Api.KRM.V1.Result.t()]
        }
  defstruct [:api_version, :function_config, :items, :kind, :results]

  def __reflection__(:mapper) do
    [
      api_version: {"apiVersion", :string},
      function_config: {"functionConfig", :map},
      items: {"items", {:array, :map}},
      kind: {"kind", :string},
      results: {"results", {:array, Kpto.Api.KRM.V1.Result}}
    ]
  end
end
