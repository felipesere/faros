defmodule Faros.Seach.ViewTest do
  use ExUnit.Case
  use Faros.ConnCase
  alias Faros.Search.View
  alias Faros.Books.Book
  alias Faros.Papers.Paper

  test "get url for book" do
    book = %Book {slug: "abc"}

    assert View.url_for(conn(), book) == "/books/abc"
  end

  test "get url for paper" do
    paper = %Paper {slug: "abc"}

    assert View.url_for(conn(), paper) == "/papers/abc"
  end
end
