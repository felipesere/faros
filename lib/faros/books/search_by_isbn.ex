defmodule Faros.Books.SearchByIsbn do

  def execute(isbn) do
    Application.get_env(:faros, :find_by_isbn).find_by_isbn(isbn)
  end
end
