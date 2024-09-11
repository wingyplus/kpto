# This code generated by `mix kpt.codegen`. PLEASE DO NOT EDIT.
defmodule Kpto.Api.Kptfile.V1.ObjectMeta do
  @moduledoc """
  ObjectMeta contains metadata about a Resource
  """

  @type t() :: %__MODULE__{
          annotations: map(),
          labels: map(),
          name: String.t(),
          namespace: String.t()
        }
  defstruct [:annotations, :labels, :name, :namespace]
end