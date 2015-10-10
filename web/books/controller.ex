defmodule Faros.Books.Controller do
  use Faros.Web, :controller
  alias Faros.Books.Query
  alias Faros.Books.Book
  alias Faros.Books.SearchByIsbn
  alias Faros.Categories.Repository, as: CategoryRepo

  def index(conn, _) do
    render conn, "index.html", books: Query.all()
  end

  def add(conn, _) do
    changeset = Book.changeset(%Book{})
    render conn, "create.html", changeset: changeset
  end

  def create(conn, %{"book" => book, "category" => category}) do
    case Query.save(book) do
      {:ok, book} ->
                  CategoryRepo.save_relation(category, book)
                  redirect conn, to: "/books"
      {:error, changeset} -> render conn, "create.html", changeset: changeset
    end
  end

  def create(conn, %{"book" => book }) do
    case Query.save(book) do
      {:ok, _book} -> redirect conn, to: "/books"
      {:error, changeset} -> render conn, "create.html", changeset: changeset
    end
  end


  def show(conn, %{"slug" => slug}) do
    book = Query.find_by_slug(slug)
    categories = CategoryRepo.find_categories_for(book)

    render conn, "book.html", book: book, categories: categories
  end

  def edit(conn, %{"slug" => slug}) do
    changeset = slug
                |> Query.find_by_slug
                |> Book.changeset

    render conn, "form.html", changeset: changeset
  end

  def delete(conn, %{"slug" => slug}) do
    Query.find_by_slug(slug)
    |> Query.delete

    redirect conn, to: "/books"
  end

  def lookup(conn, %{"isbn" => isbn}) do
    case SearchByIsbn.execute(isbn) do
      {:ok, book} -> render conn, "lookup.json", %{book: book}
      _           -> send_resp conn, 404, ""
    end
  end

  def update(conn, %{"slug" => slug, "book" => data}) do
     case update(slug, data) do
        {:ok, book} -> render conn, "book.html", book: book, categories: []
        {:error, changeset} -> render conn, "form.html", changeset: changeset
     end
  end

  def update(slug, data) do
    slug
     |> Query.find_by_slug
     |> Query.update_book(data)
  end
end
