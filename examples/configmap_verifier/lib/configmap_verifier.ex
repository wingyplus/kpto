defmodule ConfigmapVerifier do
  @moduledoc """
  Documentation for `ConfigmapVerifier`.
  """

  @behaviour Kpto.Fn

  def run(%Kpto.Api.KRM.V1.ResourceList{items: items} = resource_list) do
    results =
      items
      |> Enum.filter(&only_config_map/1)
      |> Enum.filter(&no_namespace/1)
      |> Enum.map(&into_result/1)

    %{resource_list | results: results}
  end

  defp into_result(resource) do
    %Kpto.Api.KRM.V1.Result{
      field: nil,
      message: "Namespace is missing",
      resource_ref: %{
        api_version: resource["apiVersion"],
        kind: resource["kind"],
        name: resource["metadata"]["name"],
        namespace: ""
      },
      severity: :error,
      tags: %{}
    }
  end

  defp only_config_map(resource), do: resource["kind"] == "ConfigMap"

  defp no_namespace(config_map) do
    config_map
    |> get_in(["metadata", "namespace"])
    |> is_nil()
  end
end
