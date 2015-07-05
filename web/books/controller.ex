defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  plug :action

  alias Lighthouse.BookRepository

  def index(conn, _params) do
    conn
    |> assign(:books, BookRepository.all())
    |> render "index.html"
  end

  def show(conn, %{"slug" => slug}) do
    {_, book} = BookRepository.find_by_slug(slug)

    conn
    |> assign(:book, book)
    |> render "book.html"
  end
end
