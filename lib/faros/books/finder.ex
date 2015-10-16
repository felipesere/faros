defmodule Faros.Books.Finder do
  alias Faros.Slugger

  def find_by_title(title) do
    title
    |> sanitise_title
    |> build_url(:title)
    |> read
  end

  def find_by_isbn(isbn) do
    isbn
    |> sanitise
    |> build_url(:isbn)
    |> read
  end

  def read(url) do
    url
    |> HTTPotion.get
    |> Map.get(:body)
    |> parse
  end

  def sanitise_title(title) do
    URI.encode_www_form(title)
  end

  defp sanitise(isbn) do
    String.replace(isbn, "-", "")
  end

  def build_url(thing, kind) do
    "https://www.googleapis.com/books/v1/volumes\?q\=#{query(kind)}:#{thing}"
  end

  def query(kind) do
    case kind do
      :title -> "intitle"
      :isbn  -> "isbn"
    end
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
    title = api_book["title"]
    book = %{
      title:       title,
      description: api_book["description"],
      link:        api_book["infoLink"],
      slug:        Slugger.generate(title),
      isbn:        extract_identifier(api_book["industryIdentifiers"])
    }
    {:ok, book}
  end

  def extract_identifier([]), do: :nil
  def extract_identifier([%{"identifier" => isbn, "type" => "ISBN_13"} | _]) do
    isbn
  end
  def extract_identifier([_ | rest]), do: extract_identifier(rest)
end
