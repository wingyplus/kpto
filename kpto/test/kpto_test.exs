defmodule KptoTest do
  use ExUnit.Case
  doctest Kpto

  test "greets the world" do
    assert Kpto.hello() == :world
  end
end
