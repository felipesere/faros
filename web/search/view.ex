defmodule Faros.Search.View do
  use Faros.Web, :view
  alias Faros.Books.Book
  alias Faros.Papers.Paper

  def url_for(conn, %Book{ slug: slug }) do
    books_path(conn, :show, slug)
  end

  def url_for(conn, %Paper{ slug: slug }) do
    papers_path(conn, :show, slug)
  end
end
