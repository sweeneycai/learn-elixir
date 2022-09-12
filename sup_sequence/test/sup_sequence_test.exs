defmodule SupSequenceTest do
  use ExUnit.Case
  doctest SupSequence

  test "greets the world" do
    assert SupSequence.hello() == :world
  end
end
