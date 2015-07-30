defmodule Lighthouse.Books.IsbnLookupTest do
  use ExUnit.Case, async: true
  alias Lighthouse.Books.IsbnLookup
  alias Lighthouse.Books.Book

  test "converts the book from json to domain Book" do
    expected_book = %Book{
      :title       => title,
      :description => description,
      :link        => link
    }
    assert IsbnLookup.as_book(raw_response) == expected_book
  end

  def title,       do: "Practical Object-oriented Design in Ruby"
  def description, do: "POODR description"
  def link,        do: "link.com"

  def raw_response do
    """
{
  "items": [
    {
      "volumeInfo": {
        "title": "#{title}",
        "description": "#{description}",
        "infoLink": "#{link}"
      }
    }
  ]
}
"""
  end
end
