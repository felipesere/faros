defmodule Faros.Books.QueryTest do
  use Faros.RepositoryCase
  import Faros.SampleData, only: [sample_book: 0, sample_book: 1]
  alias Faros.Books.Query

  test "save a book to the database" do
    {:ok, book} = sample_book() |> Query.save

    assert sample_book().slug == book.slug
  end

  test "can not save book with title less than three characters" do
    {:error, changeset} = %{ sample_book() | title: "" } |> Query.save
    assert changeset.errors[:title]
  end

  test "will not save book with an invalid URL" do
    {:error, changeset} = %{ sample_book() | link: "not-really-a-url" } |> Query.save
    assert changeset.errors[:link]
  end

  test "will normalize ISBN before saving" do
    {:ok, book} = %{ sample_book() | isbn: "1234-5678-9012-3"} |> Query.save
    assert "1234567890123" == book.isbn
  end

  test "will not save a book with a short isbn" do
    {:error, changeset} = %{ sample_book() | isbn: "123" } |> Query.save
    assert changeset.errors[:isbn]
  end

  test "isbn may only contain numeric values" do
    {:error, changeset} = %{ sample_book() | isbn: "123-456-789-abcd" } |> Query.save
    assert changeset.errors[:isbn]
  end

  test "will not save if slug is not present" do
    {:error, changeset} = %{ sample_book() | slug: "" } |> Query.save
    assert changeset.errors[:slug]
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
    {:ok, book} = sample_book("Some book") |> Query.save

    Query.delete(book)

    assert Query.find_by_slug("some-book") == nil
  end

  test "trying to delete an non-existent book" do
    assert Query.delete(nil) == {:error, "invalid slug"}
  end

  test "updates a book" do
    {:ok, book} = sample_book() |> Query.save
    {:ok, updated} = Query.update_book(book, %{ title: "abc"})
    assert updated.title == "abc"
  end
end
