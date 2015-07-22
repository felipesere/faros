defmodule Lighthouse.Search.View do
  use Lighthouse.Web, :view
  alias Lighthouse.Books.Book
  alias Lighthouse.Papers.Paper

  def url_for(conn, %Book{ slug: slug }) do
    books_path(conn, :show, slug)
  end

  def url_for(conn, %Paper{ slug: slug }) do
    papers_path(conn, :show, slug)
  end
end
