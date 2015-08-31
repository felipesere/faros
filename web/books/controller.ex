defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Books.Repository
  alias Lighthouse.Books.Book
  alias Lighthouse.Books.SearchByIsbn
  alias Lighthouse.Categories.Repository, as: CategoryRepo

  def index(conn, _params) do
    render conn, "index.html", books: Repository.all()
  end

  def add(conn, _params) do
    conn
    |> render "create.html"
  end

  def create(conn, %{"book" => book, "category" => category}) do
    book = %Book{} |> Book.changeset(book) |> Repository.save

    CategoryRepo.save_relation(category, book)

    redirect conn, to: "/books"
  end

  def create(conn, %{"book" => book}) do
    Book.changeset(%Book{}, book)
    |> Repository.save

    redirect conn, to: "/books"
  end

  def show(conn, %{"slug" => slug}) do
    {:ok, book} = Repository.find_by_slug(slug)

    categories = CategoryRepo.find_categories_for(book)

    conn
    |> assign(:book, book)
    |> assign(:categories, categories)
    |> render "book.html"
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
    |> assign(:categories, [])
    |> render "book.html"
  end
end
