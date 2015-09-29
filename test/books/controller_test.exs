defmodule Faros.Books.ControllerTest do
  import Faros.SampleData, only: [sample_book: 0]
  alias Faros.Books.Query
  use Faros.ConnCase
  use Faros.RepositoryCase

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
    params = %{
      "isbn"        => "a",
      "title"       => "something",
      "slug"        => "the-book",
      "description" => "d",
      "link"        => "e"
    }
    post conn(), "/books", %{book: params}

    conn = get conn(), "/books/#{params[:slug]}"
    assert html_response(conn, 200)
  end

  test "adds a book with a category" do
    category = %Category{name: "marketing"} |> Repo.insert!

    params = %{
      "isbn"        => "a",
      "title"       => "something",
      "slug"        => "the-book",
      "description" => "d",
      "link"        => "e"
    }
    post conn(), "/books", %{"book" => params, "category" => category.name}

    conn = get conn(), "/books/#{params["slug"]}"
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
    conn = post conn(), "/books/#{book.slug}/edit", %{book: %{title: "Updated"}}
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Updated"
  end

  test "looks up book by isbn" do
    conn = get conn(), "/api/books/lookup", %{"isbn" => 123}

    assert json_response(conn, 200) == %{ "book" => %{ "title" => "A Book","isbn" => 123 }}
  end
end
