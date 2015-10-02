defmodule Faros.Books.QueryTest do
  use Faros.RepositoryCase
  import Faros.SampleData, only: [sample_book: 0]
  alias Faros.Books.Query

  test "save a book to the database" do
    book = sample_book()
    saved_book = book |> Repo.insert!

    assert saved_book.slug == book.slug
  end

  test "can find a book by partial title" do
    book = sample_book() |> Repo.insert!
    partial_title = book.title |> String.split |> List.first
    assert Query.search(partial_title) == [book]
  end

  test "can find a book" do
    book = sample_book() |> Repo.insert!
    found_book = Query.find_by_slug(book.slug)

    assert found_book == book
  end

  test "errors if it can not be found" do
    assert Query.find_by_slug("does-not-exist") == nil
  end
end
