defmodule Lighthouse.Books.RepositoryTest do
  use Lighthouse.RepositoryCase
  import Lighthouse.SampleData, only: [sample_book: 0]
  alias Lighthouse.Books.Repository

  test "save a book to the database" do
    book = sample_book()
    saved_book = book |> Repo.insert!

    assert saved_book.slug == book.slug
  end

  test "can find a book by partial title" do
    book = sample_book() |> Repo.insert!
    partial_title = book.title |> String.split |> List.first
    assert Repository.search(partial_title) == [book]
  end

  test "can find a book" do
    book = sample_book() |> Repo.insert!
    {:ok, found_book} = Repository.find_by_slug(book.slug)

    assert found_book == book
  end

  test "errors if it can not be found" do
    {error, _} = Repository.find_by_slug("does-not-exist")
    assert error == :not_found
  end
end
