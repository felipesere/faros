defmodule Lighthouse.Books.RepositoryTest do
  use ExUnit.Case
  use Phoenix.ConnTest
  alias Lighthouse.Books.Repository
  alias Lighthouse.Books.Book

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Lighthouse.Repo, [])
    end

    :ok
  end

  test "save a book to the database" do
    book = sample_book()
    saved_book = Repository.save(book)

    assert saved_book.slug == "that-book"
  end

  test "can find a book" do
    Repository.save(sample_book())
    {_, book} = Repository.find_by_slug("that-book")

    assert book.slug == "that-book"
  end

  test "errors if it can not be found" do
    {error, _} = Repository.find_by_slug("does-not-exist")
    assert error == :not_found
  end

  test "updates a book" do
    the_book = Repository.save(sample_book())
    Repository.update_book(the_book, %{title: "Updated"})
    {:ok, book} = Repository.find_by_slug(the_book.slug)

    assert book.title == "Updated"
  end

  def sample_book() do
    %Book{  isbn:  "1234",
            title: "That book",
            slug:  "that-book",
            description: "Its pretty cool.",
            link:  "http://example.com/books/that-book"}
  end
end
