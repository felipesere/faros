defmodule Lighthouse.Books.View do
  use Lighthouse.Web, :view

  def render("lookup.json", %{book: book}) do
    book
  end
end
