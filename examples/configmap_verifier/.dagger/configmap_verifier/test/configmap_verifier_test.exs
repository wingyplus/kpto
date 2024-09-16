defmodule ConfigmapVerifierTest do
  use ExUnit.Case
  doctest ConfigmapVerifier

  test "greets the world" do
    assert ConfigmapVerifier.hello() == :world
  end
end
