defmodule Mix.Tasks.Kpt.Codegen do
  @shortdoc "Generate Kpt type from openapi spec"
  @moduledoc @shortdoc

  use Mix.Task

  def run(args) do
    {opts, [], []} =
      OptionParser.parse(args,
        strict: [input: :string, outdir: :string],
        aliases: [i: :input, o: :outdir]
      )

    input = Keyword.fetch!(opts, :input)
    outdir = Keyword.fetch!(opts, :outdir)

    input
    |> Path.expand()
    |> YamlElixir.read_from_file!()
    |> KptoCodegen.generate()
    |> Enum.map(&format_and_write(&1, outdir))
  end

  defp format_and_write({filename, code}, outdir) do
    File.mkdir_p!(outdir)

    Path.join([outdir, filename])
    |> File.write!(Code.format_string!(code))
  end
end
