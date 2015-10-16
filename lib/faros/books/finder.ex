defmodule Faros.Books.Finder do

  def find_by_title(title) do
    get.find_by_title(title)
  end

  def find_by_isbn(isbn) do
    get.find_by_isbn(isbn)
  end

  defp get do
    Application.get_env(:faros, :book_finder)
  end
end
