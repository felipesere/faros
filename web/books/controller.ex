defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Books.Repository
  alias Lighthouse.Books.Book

  def index(conn, _params) do
    conn
    |> assign(:books, Repository.all())
    |> render "index.html"
  end

  def add(conn, _params) do
    conn
    |> render "create.html"
  end

  def create(conn, %{"book" => book}) do
    Book.changeset(%Book{}, book)
    |> Repository.save

    redirect conn, to: "/books"
  end

  def show(conn, %{"slug" => slug}) do
    {_, book} = Repository.find_by_slug(slug)

    view(book, conn)
  end

  def form(conn, %{"slug" => slug}) do
    slug
    |> Repository.find_by_slug
    |> show_form(conn)
  end

  defp show_form({:ok, book}, conn) do
    conn
    |> assign(:book, book)
    |> render "form.html"
  end

  def edit(conn, %{"slug" => slug, "book" => data}) do
    slug
    |> Repository.find_by_slug
    |> update(data)
    |> view(conn)
  end

  defp update({:ok, book}, data), do: Repository.update_book(book, data)

  defp view(book, conn) do
    conn
    |> assign(:book, book)
    |> render "book.html"
  end
end
