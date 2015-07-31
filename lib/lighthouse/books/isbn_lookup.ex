defmodule Lighthouse.Books.IsbnLookup do
  alias Lighthouse.Books.Book

  def find_by_isbn(isbn) do
    isbn
    |> sanitise
    |> build_url
    |> HTTPotion.get
    |> Map.get(:body)
    |> as_book
  end

  def as_book(raw_response) do
    raw_response
    |> Poison.Parser.parse!
    |> Map.get("items")
    |> List.first
    |> Map.get("volumeInfo")
    |> extract_book
  end

  defp sanitise(isbn) do
    String.replace(isbn, "-", "")
  end

  defp build_url(isbn) do
    "https://www.googleapis.com/books/v1/volumes\?q\=isbn:#{isbn}"
  end

  defp extract_book(api_book) do
    %Book{
      :title       => api_book["title"],
      :description => api_book["description"],
      :link        => api_book["infoLink"]
    }
  end
end
