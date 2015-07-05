defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  plug :action
  import String, only: [to_atom: 1]

  alias Lighthouse.BookRepository

  def index(conn, _params) do
    conn
    |> assign(:books, BookRepository.all())
    |> render "index.html"
  end

  def show(conn, %{"slug" => slug}) do
    {_, book} = BookRepository.find_by_slug(slug)

    view(book, conn)
  end

  def edit(conn, data =  %{"slug" => slug}) do
    slug
    |> BookRepository.find_by_slug
    |> update(data)
    |> view(conn)
  end

  defp update({:ok, book}, data) do
    clean = to_keyword_list(data)
    BookRepository.update_book(book, clean)
  end

  defp to_keyword_list(data) do
    Enum.map data, fn({k,v}) -> {to_atom(k), v} end
  end

  defp view(book, conn) do
    conn
    |> assign(:book, book)
    |> render "book.html"
  end
end
