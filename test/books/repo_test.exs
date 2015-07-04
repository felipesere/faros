defmodule Lighthouse.RepoTest do
  use ExUnit.Case
  use Phoenix.ConnTest
  alias Lighthouse.Repo
  alias Lighthouse.Book

  setup do
    Repo.delete_all(Book)

    :ok
  end

  test "save a book to the database" do
    book = sample_book()
    saved_book = Repo.insert(book)

    assert saved_book.slug == "that-book"
  end

  test "can find a book" do
    Repo.insert(sample_book())
    {_, book} = Repo.find_by_slug("that-book")

    assert book.slug == "that-book"
  end

  test "errors if it can not be found" do
    nothing = Repo.find_by_slug("does-not-exist")
    assert nothing == {:not_found, nil}
  end

  def sample_book() do
    %Book{  isbn:  "1234",
            title: "That book",
            slug:  "that-book",
            description: "Its pretty cool.",
            link:  "http://example.com/books/that-book"}
  end
end
