defmodule Faros.Books.FinderTest do
  use ExUnit.Case, async: true
  alias Faros.Books.Finder

  @tag :integration
  test "fetches a book based on isbn" do
    clean_code_isbn = "9780132350884"
    {:ok, book} = Finder.find_by_isbn(clean_code_isbn)

    assert book.title == "Clean Code"
    assert book.slug == "clean-code"
  end

  test "fetches a book based on title" do
    clean_code_title = "clean code"
    {:ok, book} = Finder.find_by_title(clean_code_title)

    assert book.isbn  == "9780132350884"
  end

  test "returns not found when the results are empty" do
    no_results_response = "{}"
    assert Finder.parse(no_results_response) == {:not_found}
  end
end
