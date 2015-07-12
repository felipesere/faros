defmodule Lighthouse.Books.ControllerTest do
  use Lighthouse.ConnCase
  alias Lighthouse.BookRepository
  alias Lighthouse.Book

  setup do
    BookRepository.delete_all
    BookRepository.save(sample_book())

    :ok
  end

  defp sample_book() do
    %Book{isbn: "a", title: "b", slug: "the-book", description: "d", link: "e"}
  end

  test "returns 200" do
    %{status: status} = get conn(), "/books"
    assert status == 200
  end

  test "renders all books" do
    conn = get conn(), "/books"
    book = BookRepository.all() |> List.first
    assert html_response(conn, 200) =~ book.title
  end

  test "renders single book" do
    book = BookRepository.all() |> List.first
    conn = get conn(), "/books/#{book.slug}"
    assert html_response(conn, 200) =~ book.title
    assert html_response(conn, 200) =~ "/books/#{book.slug}/edit"
  end

  test "renders add book" do
    %{status: status} = get conn(), "/books/add"
    assert status == 200
  end

  test "adds a book" do
    params = %{isbn: "a", title: "b", slug: "the-book", description: "d", link: "e"}
    post conn(), "books/add", %{book: params}
    book = BookRepository.all() |> List.first
    assert book.title == params.title
  end

  test "has form to update book" do
    conn = get conn(), "/books/the-book/edit"
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Description"
  end

  test "updates a book" do
    conn = post conn(), "/books/the-book/edit", %{book: %{title: "Updated"}}
    assert conn.status == 200
    assert html_response(conn, 200) =~ "Updated"
  end
end
