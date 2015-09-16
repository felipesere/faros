defmodule Lighthouse.Books.SearchByIsbn do

  def execute(isbn) do
    Application.get_env(:lighthouse, :find_by_isbn).find_by_isbn(isbn)
  end
end
