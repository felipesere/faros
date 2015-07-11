defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.BookRepository
  alias Lighthouse.Book

  def index(conn, _params) do
    conn
    |> assign(:books, BookRepository.all())
    |> render "index.html"
  end

  def add(conn, _params) do
    conn
    |> render "create.html"
  end

  def create(conn, %{"book" => book}) do
    Book.changeset(%Book{}, book)
    |> BookRepository.save

    redirect conn, to: "/books"
  end

  def show(conn, %{"slug" => slug}) do
    {_, book} = BookRepository.find_by_slug(slug)

    view(book, conn)
  end

  def form(conn, %{"slug" => slug}) do
    slug
    |> BookRepository.find_by_slug
    |> show_form(conn)
  end

  defp show_form({:ok, book}, conn) do
    conn
    |> assign(:book, book)
    |> render "form.html"
  end

  def edit(conn, %{"slug" => slug, "book" => data}) do
    slug
    |> BookRepository.find_by_slug
    |> update(data)
    |> view(conn)
  end

  defp update({:ok, book}, data), do: BookRepository.update_book(book, data)

  defp view(book, conn) do
    conn
    |> assign(:book, book)
    |> render "book.html"
  end
end
