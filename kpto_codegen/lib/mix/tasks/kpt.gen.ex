defmodule Mix.Tasks.Kpt.Codegen do
  @shortdoc "Generate Kpt type from openapi spec"
  @moduledoc @shortdoc

  use Mix.Task

  def run(args) do
    {opts, [], []} =
      OptionParser.parse(args,
        strict: [input: :string, outdir: :string, namespace: :string],
        aliases: [i: :input, o: :outdir, n: :namespace]
      )

    input = Keyword.fetch!(opts, :input)
    outdir = Keyword.fetch!(opts, :outdir)
    namespace = Keyword.fetch!(opts, :namespace)

    input
    |> Path.expand()
    |> YamlElixir.read_from_file!()
    |> KptoCodegen.generate(namespace)
    |> Enum.map(&format_and_write(&1, outdir))
  end

  defp format_and_write({dir, filename, code}, outdir) do
    File.mkdir_p!(Path.join(outdir, dir))

    Path.join([outdir, dir, filename])
    |> File.write!(Code.format_string!(code))
  end
end
