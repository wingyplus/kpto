defmodule Kpto.YAML do
  @moduledoc """
  Provides a way to encode/decode YAML into struct (and do reverse) with automatic 
  serialize the name.
  """

  def encode(struct) when is_struct(struct) do
    struct
    |> encode_to_map()
    |> Ymlr.document!()
    |> String.trim_leading("---\n")
  end

  defp encode_to_map(%module{} = struct) do
    dump(struct, {:map, module.__reflection__(:mapper)})
  end

  def decode(yaml, module) when is_binary(yaml) and is_atom(module) do
    yaml = YamlElixir.read_from_string!(yaml)
    decode_to_struct(yaml, module)
  end

  defp decode_to_struct(yaml, module) do
    kv =
      for {key, {yaml_key, type}} <- module.__reflection__(:mapper) do
        {key, cast(yaml[yaml_key], type)}
      end

    struct(module, kv)
  end

  defp cast(nil, _), do: nil
  defp cast(value, :string) when is_binary(value), do: value
  defp cast(value, {:array, type}) when is_list(value), do: Enum.map(value, &cast(&1, type))
  defp cast(value, :map) when is_map(value), do: value
  defp cast(value, {:map, module}) when is_map(value), do: decode_to_struct(value, module)

  defp dump(%module{} = struct, {:map, module}) do
    for {key, {yaml_key, type}} <- module.__reflection__(:mapper), into: %{} do
      {yaml_key, dump(Map.fetch!(struct, key), type)}
    end
  end

  defp dump(%{} = map, {:map, type}) when is_list(type) do
    for {key, {yaml_key, type}} <- type, into: %{} do
      {yaml_key, dump(Map.fetch!(map, key), type)}
    end
  end

  defp dump(nil, {:array, _}), do: []
  defp dump(elems, {:array, type}), do: Enum.map(elems, &dump(&1, {:map, type}))

  defp dump(value, _), do: value
end
