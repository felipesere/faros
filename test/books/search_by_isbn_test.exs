defmodule Faros.Books.SearchByIsbnTest do
  use ExUnit.Case, async: true
  alias Faros.Books.SearchByIsbn

  test "fetches book by isbn" do
    expected_book = SearchByIsbn.execute("isbn")

    assert expected_book.title == "A Book"
  end
end
