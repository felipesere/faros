defmodule Lighthouse.Books.IsbnLookup do

  def find_by_isbn(isbn) do
    isbn
    |> sanitise
    |> build_url
    |> HTTPotion.get
    |> Map.get(:body)
    |> parse
  end

  defp sanitise(isbn) do
    String.replace(isbn, "-", "")
  end

  defp build_url(isbn) do
    "https://www.googleapis.com/books/v1/volumes\?q\=isbn:#{isbn}"
  end

  def parse(raw_response) do
    raw_response
    |> Poison.Parser.parse!
    |> Map.get("items", [])
    |> List.first
    |> as_book
  end

  defp as_book(nil) do
    {:not_found}
  end

  defp as_book(%{"volumeInfo" => api_book}) do
    book = %{
      title:       api_book["title"],
      description: api_book["description"],
      link:        api_book["infoLink"]
    }
    {:ok, book}
  end
end