defmodule Faros.Books.Finder do

  def get do
    Application.get_env(:faros, :book_finder)
  end
end
