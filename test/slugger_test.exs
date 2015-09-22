defmodule Lighthouse.SluggerTest do
  use ExUnit.Case
  alias Lighthouse.Slugger

  test "lowercases for the slug" do
    assert Slugger.generate("Foo") == "foo"
  end

  test "replaces whitespace with hypens" do
    assert Slugger.generate("foo bar") == "foo-bar"
  end

  test "it removes punctuation" do
    assert Slugger.generate("Foo: Bar; Batz,\ Blub. /Bleh") == "foo-bar-batz-blub-bleh"
  end
end
