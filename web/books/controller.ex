defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Books.Repository
  alias Lighthouse.Books.Book
  alias Lighthouse.Books.SearchByIsbn
  alias Lighthouse.Categories.Repository, as: CategoryRepo

  def index(conn, _) do
    render conn, "index.html", books: Repository.all()
  end

  def add(conn, _) do
    render conn, "create.html"
  end

  def create(conn, %{"book" => book, "category" => category}) do
    book = %Book{} |> Book.changeset(book) |> Repository.save

    CategoryRepo.save_relation(category, book)

    redirect conn, to: "/books"
  end

  def create(conn, %{"book" => book}) do
    %Book{} |> Book.changeset(book) |> Repository.save

    redirect conn, to: "/books"
  end

  def show(conn, %{"slug" => slug}) do
    {:ok, book} = Repository.find_by_slug(slug)

    categories = CategoryRepo.find_categories_for(book)

    render conn, "book.html", book: book, categories: categories
  end

  def form(conn, %{"slug" => slug}) do
    {:ok, book} = Repository.find_by_slug(slug)

    render conn, "form.html", book: book
  end

  def lookup(conn, %{"isbn" => isbn}) do
    case SearchByIsbn.execute(isbn) do
      {:ok, book} -> render conn, book: Poison.encode!(book)
      _           -> send_resp conn, 404, ""
    end
  end

  def edit(conn, %{"slug" => slug, "book" => data}) do
    {:ok, book} = slug |> Repository.find_by_slug
    book = book
    |> Repository.update_book(data)

    render conn, "book.html", book: book, categories: []
  end
end
