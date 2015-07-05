defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  plug :action

  alias Lighthouse.Repository

  def index(conn, _params) do
    conn
    |> assign(:books, Repository.all())
    |> render "index.html"
  end

  def show(conn, %{"slug" => slug}) do
    {_, book} = Repository.find_by_slug(slug)

    conn
    |> assign(:book, book)
    |> render "book.html"
  end
end
