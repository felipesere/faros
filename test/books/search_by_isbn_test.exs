defmodule Faros.Books.SearchByIsbnTest do
  use ExUnit.Case, async: true
  alias Faros.Books.SearchByIsbn

  test "fetches book by isbn" do
    {:ok, expected_book} = SearchByIsbn.finder().find_by_isbn("isbn")

    assert expected_book.title == "That Book"
  end
end
