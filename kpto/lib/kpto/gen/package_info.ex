# This code generated by `mix kpt.codegen`. PLEASE DO NOT EDIT.
defmodule Kpto.Api.Kptfile.V1.PackageInfo do
  @moduledoc """
  PackageInfo contains optional information about the package such as license, documentation, etc.
  """

  @type t() :: %__MODULE__{
          description: String.t(),
          emails: [String.t()],
          keywords: [String.t()],
          license: String.t(),
          license_file: String.t(),
          man: String.t(),
          site: String.t()
        }
  defstruct [:description, :emails, :keywords, :license, :license_file, :man, :site]
end