defmodule Lighthouse.Books.ControllerTest do
  use Lighthouse.ConnCase
  alias Lighthouse.Books.Book

  defp sample_book() do
    %Book{isbn: "a", title: "b", slug: "the-book", description: "d", link: "e"}
  end

  test "returns 200" do
    Repository.save(sample_book())
    conn = get conn(), "/books"
    assert html_response(conn, 200)
  end

  test "renders all books" do
    book = Repository.save(sample_book())

    conn = get conn(), "/books"
    assert html_response(conn, 200) =~ book.title
  end

  test "renders single book" do
    book = Repository.save(sample_book())

    conn = get conn(), "/books/#{book.slug}"

    assert html_response(conn, 200) =~ book.title
    assert html_response(conn, 200) =~ "/books/#{book.slug}/edit"
  end

  test "renders add book" do
    %{status: status} = get conn(), "/books/add"
    assert status == 200
  end

  test "adds a book" do
    params = %{isbn: "a", title: "something", slug: "the-book", description: "d", link: "e"}
    post conn(), "/books", %{book: params}

    conn =  get conn(), "/books/#{params[:slug]}"
    assert html_response(conn, 200)
  end

  test "has form to update book" do
    book = Repository.save(sample_book())
    conn = get conn(), "/books/#{book.slug}/edit"
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Description"
  end

  test "updates a book" do
    book = Repository.save(sample_book())
    conn = post conn(), "/books/#{book.slug}/edit", %{book: %{title: "Updated"}}
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Updated"
  end
end
