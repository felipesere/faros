defmodule Lighthouse.Seach.ViewTest do
  use ExUnit.Case
  use Lighthouse.ConnCase
  alias Lighthouse.Search.View
  alias Lighthouse.Books.Book
  alias Lighthouse.Papers.Paper

  test "get url for book" do
    book = %Book { slug: "abc"}

    assert View.url_for(conn(), book) == "/books/abc"
  end

  test "get url for paper" do
    paper = %Paper { slug: "abc" }

    assert View.url_for(conn(), paper) == "/papers/abc"
  end
end
