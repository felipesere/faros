defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Books.Repository
  alias Lighthouse.Books.Book
  alias Lighthouse.Books.SearchByIsbn

  def index(conn, _params) do
    conn
    |> assign(:books, Repository.all())
    |> render "index.html"
  end

  def add(conn, _params) do
    changeset = Book.changeset(%Book{})
    conn
    |> render "create.html", changeset: changeset
  end

  def create(conn, %{"book" => book}) do
    case Repository.save(book) do
      {:ok, _} -> redirect conn, to: "/books"
      {:error, changeset} -> render conn, "create.html", changeset: changeset
    end
  end

  def show(conn, %{"slug" => slug}) do
    {:ok, book} = Repository.find_by_slug(slug)

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

  def lookup(conn, %{"isbn" => isbn}) do
    case SearchByIsbn.execute(isbn) do
      {:ok, book} -> render conn, book: Poison.encode!(book)
      _           -> send_resp conn, 404, ""
    end
  end

  defp update({:ok, book}, data), do: Repository.update_book(book, data)

  defp view(book, conn) do
    conn
    |> assign(:book, book)
    |> render "book.html"
  end
end
