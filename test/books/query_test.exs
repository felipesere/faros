defmodule Faros.Books.QueryTest do
  use Faros.RepositoryCase
  import Faros.SampleData, only: [sample_book: 0]
  alias Faros.Books.Query

  test "save a book to the database" do
    {:ok, book} = sample_book() |> Query.save

    assert sample_book().slug == book.slug
  end

  test "slugs of books must be unique" do
    {:ok, _} = sample_book() |> Query.save
    {:error, changeset} = sample_book() |> Query.save
    assert changeset.errors[:slug]
  end

  test "can find a book by partial title" do
    {:ok, book} = sample_book() |> Query.save
    partial_title = book.title |> String.split |> List.first
    assert Query.search(partial_title) == [book]
  end

  test "can find a book" do
    {:ok, book} = sample_book() |> Query.save
    found_book = Query.find_by_slug(book.slug)

    assert found_book == book
  end

  test "errors if it can not be found" do
    assert Query.find_by_slug("does-not-exist") == nil
  end

  test "it deletes a book" do
    a_book = sample_book() |> Repo.insert!

    Query.delete(a_book)

    assert Query.find_by_slug("that-book") == nil
  end
end
