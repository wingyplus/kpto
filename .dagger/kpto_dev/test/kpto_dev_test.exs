defmodule KptoDevTest do
  use ExUnit.Case
  doctest KptoDev

  test "greets the world" do
    assert KptoDev.hello() == :world
  end
end
