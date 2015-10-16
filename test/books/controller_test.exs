defmodule Faros.Books.ControllerTest do
  import Faros.SampleData, only: [sample_book: 0]
  alias Faros.Books.Query
  use Faros.ConnCase
  use Faros.RepositoryCase

  alias Faros.Books.Query
  alias Faros.Categories.Category

  test "returns 200" do
    sample_book() |> Query.save
    conn = get conn(), "/books"
    assert html_response(conn, 200)
  end

  test "renders all books" do
    {:ok, book} = sample_book() |> Query.save

    conn = get conn(), "/books"
    assert html_response(conn, 200) =~ book.title
  end

  test "renders single book" do
    {:ok, book} = sample_book() |> Query.save

    conn = get conn(), "/books/#{book.slug}"

    assert html_response(conn, 200) =~ book.title
    assert html_response(conn, 200) =~ "/books/#{book.slug}/edit"
  end

  test "renders add book" do
    %{status: status} = get conn(), "/books/add"
    assert status == 200
  end

  test "adds a book" do
    book = sample_book()
    post conn(), "/books", %{book: book}

    conn = get conn(), "/books/#{book[:slug]}"
    assert html_response(conn, 200)
  end

  test "adds a book with a category" do
    category = %Category{name: "marketing"} |> Repo.insert!

    book = sample_book()
    post conn(), "/books", %{book: book, category: category.name}

    conn = get conn(), "/books/#{book[:slug]}"
    assert html_response(conn, 200) =~ category.name
  end

  test "returns to form if there were errors" do
    book = sample_book()
    {:ok, _} = Query.save(book)
    conn = post conn(), "/books", %{book: book}

    assert html_response(conn, 200) =~ "Add Book"
  end

  test "has form to update book" do
    {:ok, book} = sample_book() |> Query.save
    conn = get conn(), "/books/#{book.slug}/edit"
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Description"
  end

  test "updates a book" do
    {:ok, book} = sample_book() |> Query.save
    conn = put conn(), "/books/#{book.slug}/edit", %{book: %{title: "Updated"}}
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Updated"
  end

  test "does not update an invalid book" do
    {:ok, book} = sample_book() |> Query.save
    conn = put conn(), "/books/#{book.slug}/edit", %{book: %{isbn: "123"}}
    assert conn.status == 200
    assert html_response(conn, 200) =~ "error"
  end

  test "looks up book by isbn" do
    conn = get conn(), "/api/books/lookup", %{"isbn" => 123}

    assert json_response(conn, 200) == %{ "book" => %{ "title" => "That Book", "isbn" => 123, "slug" => "that-book", "description" => "Its pretty cool.", "link" => "http://example.com/books/that-book" }}
  end

  test "deletes a book" do
    {:ok, book} = sample_book() |> Query.save

    conn = delete conn(), "/books/#{book.slug}"

    assert html_response(conn, 302) =~ "/books"
    assert Query.find_by_slug(book.slug) == nil
  end
end
