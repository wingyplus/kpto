# This code generated by `mix kpt.codegen`. PLEASE DO NOT EDIT.
defmodule Kpto.Api.Kptfile.V1.Selector do
  @moduledoc """
  Selector specifies the selection criteria
  please update IsEmpty method if more properties are added
  """

  @type t() :: %__MODULE__{
          annotations: map(),
          api_version: String.t(),
          kind: String.t(),
          labels: map(),
          name: String.t(),
          namespace: String.t()
        }
  defstruct [:annotations, :api_version, :kind, :labels, :name, :namespace]
end
