defmodule Faros.Books.SearchByIsbn do

  def finder do
    Application.get_env(:faros, :book_finder)
  end
end
