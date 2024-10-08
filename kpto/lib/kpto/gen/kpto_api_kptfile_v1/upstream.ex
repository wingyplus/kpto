# This code generated by `mix kpt.codegen`. PLEASE DO NOT EDIT.
defmodule Kpto.Api.Kptfile.V1.Upstream do
  @moduledoc """
  Upstream is a user-specified upstream locator for a package.
  """

  @type t() :: %__MODULE__{
          git: Kpto.Api.Kptfile.V1.Git.t(),
          type: Kpto.Api.Kptfile.V1.OriginType.t(),
          update_strategy: Kpto.Api.Kptfile.V1.UpdateStrategyType.t()
        }
  defstruct [:git, :type, :update_strategy]
end
