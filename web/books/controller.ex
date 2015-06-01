defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  plug :action

  alias Lighthouse.Books.Repository

  def index(conn, _params) do
    conn
    |> assign(:books, Repository.all())
    |> render "index.html"
  end

  def show(conn, %{"slug" => slug}) do
    conn
    |> assign(:book, Repository.find_by_slug(slug))
    |> render "book.html"
  end
end
