defmodule Lighthouse.Books.IsbnLookupTest do
  use ExUnit.Case, async: true
  alias Lighthouse.Books.IsbnLookup
  alias Lighthouse.Books.Book

  test "converts the first book from json to domain Book" do
    expected_book = %Book{
      :title       => title,
      :description => description,
      :link        => link
    }
    assert IsbnLookup.parse(one_result_response) == {:ok, expected_book}
  end

  test "returns not found when the results are empty" do
    assert IsbnLookup.parse(no_results_response) == {:not_found}
  end

  def title,       do: "Practical Object-oriented Design in Ruby"
  def description, do: "POODR description"
  def link,        do: "link.com"

  def one_result_response do
    """
{
  "items": [
    {
      "volumeInfo": {
        "title": "#{title}",
        "description": "#{description}",
        "infoLink": "#{link}"
      }
    },
    {
      "second book": "is ignored"
    }
  ]
}
"""
  end

  def no_results_response do
    "{}"
  end
end
