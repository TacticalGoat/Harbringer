defmodule HarbringerTest do
  use ExUnit.Case
  doctest Harbringer

  test "greets the world" do
    assert Harbringer.hello() == :world
  end
end
