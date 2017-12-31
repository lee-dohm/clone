defmodule Clone.StateTest do
  use ExUnit.Case, async: true

  alias Clone.State

  def options(options \\ [], arguments \\ [], invalid \\ []) do
    {options, arguments, invalid}
  end

  test "creates a state struct from an OptionParser tuple" do
    state = State.new(options())

    assert state.arguments == []
    assert state.invalid_options == []
    assert state.options == %{}
    assert state.location == nil
    assert state.repo_dir == nil
  end

  test "converts the options into a map so they can be pattern-matched" do
    state = State.new(options(foo: "bar"))

    assert state.options == %{foo: "bar"}
  end

  test "concatenates multiple option keys into a list" do
    state = State.new(options(foo: "bar", foo: "baz"))

    assert state.options.foo == ["baz", "bar"]
  end
end
