# This code generated by `mix kpt.codegen`. PLEASE DO NOT EDIT.
defmodule Kpto.Api.Kptfile.V1.Inventory do
  @moduledoc """
  Inventory encapsulates the parameters for the inventory resource applied to a cluster.
  """

  @type t() :: %__MODULE__{
          annotations: map(),
          inventory_id: String.t(),
          labels: map(),
          name: String.t(),
          namespace: String.t()
        }
  defstruct [:annotations, :inventory_id, :labels, :name, :namespace]
end
