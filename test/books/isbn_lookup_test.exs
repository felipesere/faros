defmodule Faros.Books.IsbnLookupTest do
  use ExUnit.Case, async: true
  alias Faros.Books.IsbnLookup

  @tag :integration
  test "fetches a book based on isbn" do
    clean_code_isbn = "9780132350884"
    {:ok, book} = IsbnLookup.find_by_isbn(clean_code_isbn)

    assert book.title == "Clean Code"
  end

  test "returns not found when the results are empty" do
    no_results_response = "{}"
    assert IsbnLookup.parse(no_results_response) == {:not_found}
  end
end
