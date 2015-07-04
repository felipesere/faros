defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  plug :action

  alias Lighthouse.Repo

  def index(conn, _params) do
    conn
    |> assign(:books, Repo.all())
    |> render "index.html"
  end

  def show(conn, %{"slug" => slug}) do
    {_, book} = Repo.find_by_slug(slug)

    conn
    |> assign(:book, book)
    |> render "book.html"
  end
end
