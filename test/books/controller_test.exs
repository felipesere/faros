defmodule Lighthouse.Books.ControllerTest do
  import Lighthouse.SampleData, only: [sample_book: 0]
  use Lighthouse.ConnCase
  use Lighthouse.RepositoryCase

  alias Lighthouse.Categories.Category

  test "returns 200" do
    sample_book() |> Repo.insert!
    conn = get conn(), "/books"
    assert html_response(conn, 200)
  end

  test "renders all books" do
    book = sample_book() |> Repo.insert!

    conn = get conn(), "/books"
    assert html_response(conn, 200) =~ book.title
  end

  test "renders single book" do
    book = sample_book() |> Repo.insert!

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
    post conn(), "/books", %{book: params, category: category.name}

    conn = get conn(), "/books/#{params["slug"]}"
    assert html_response(conn, 200) =~ category.name
  end

  test "has form to update book" do
    book = sample_book() |> Repo.insert!
    conn = get conn(), "/books/#{book.slug}/edit"
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Description"
  end

  test "updates a book" do
    book = sample_book() |> Repo.insert!
    conn = post conn(), "/books/#{book.slug}/edit", %{book: %{title: "Updated"}}
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Updated"
  end
end
