defmodule Lighthouse.Books.ControllerTest do
  use Lighthouse.ConnCase
  alias Lighthouse.Repo
  alias Lighthouse.Book

  setup do
    Repo.delete_all(Book)
    Repo.insert(sample_book())

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
    book = Repo.all() |> List.first
    assert html_response(conn, 200) =~ book.title
  end

  test "renders single book" do
    book = Repo.all() |> List.first
    conn = get conn(), "/books/#{book.slug}"
    assert html_response(conn, 200) =~ book.title
  end
end
