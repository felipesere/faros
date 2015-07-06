defmodule Lighthouse.Books.ControllerTest do
  use Lighthouse.ConnCase
  alias Lighthouse.BookRepository
  alias Lighthouse.Book

  setup do
    BookRepository.delete_all(Book)
    BookRepository.insert(sample_book())

    :ok
  end

  defp sample_book() do
    %Book{isbn: "a", title: "b", slug: "c", description: "d", link: "e"}
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
  end
end
