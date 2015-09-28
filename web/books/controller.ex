defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Repo
  alias Lighthouse.Books.Query
  alias Lighthouse.Books.Book
  alias Lighthouse.Books.SearchByIsbn
  alias Lighthouse.Categories.Repository, as: CategoryRepo

  def index(conn, _) do
    render conn, "index.html", books: Query.all()
  end

  def add(conn, _) do
    render conn, "create.html"
  end

  def create(conn, %{"book" => book, "category" => category}) do
    book = %Book{} |> Book.changeset(book) |> Repo.insert!

    CategoryRepo.save_relation(category, book)

    redirect conn, to: "/books"
  end

  def create(conn, %{"book" => book}) do
    %Book{} |> Book.changeset(book) |> Repo.insert!

    redirect conn, to: "/books"
  end

  def show(conn, %{"slug" => slug}) do
    book = Query.find_by_slug(slug)
    categories = CategoryRepo.find_categories_for(book)

    render conn, "book.html", book: book, categories: categories
  end

  def edit(conn, %{"slug" => slug}) do
    render conn, "form.html", book: Query.find_by_slug(slug)
  end

  def lookup(conn, %{"isbn" => isbn}) do
    case SearchByIsbn.execute(isbn) do
      {:ok, book} -> render conn, book: Poison.encode!(book)
      _           -> send_resp conn, 404, ""
    end
  end

  def update(conn, %{"slug" => slug, "book" => data}) do
    book = slug
    |> Query.find_by_slug
    |> Book.changeset(data)
    |> Repo.update!

    render conn, "book.html", book: book, categories: []
  end
end
