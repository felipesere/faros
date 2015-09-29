defmodule Faros.Books.View do
  use Faros.Web, :view

  def render("lookup.json", %{book: book}) do
    book
  end
end
