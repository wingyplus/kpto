# This code generated by `mix kpt.codegen`. PLEASE DO NOT EDIT.
defmodule Kpto.Api.Kptfile.V1.Function do
  @moduledoc """
  Function specifies a KRM function.
  """

  @type t() :: %__MODULE__{
          config_map: map(),
          config_path: String.t(),
          exclude: [Kpto.Api.Kptfile.V1.Selector.t()],
          exec: String.t(),
          image: String.t(),
          name: String.t(),
          selectors: [Kpto.Api.Kptfile.V1.Selector.t()]
        }
  defstruct [:config_map, :config_path, :exclude, :exec, :image, :name, :selectors]
end
