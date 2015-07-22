defmodule Lighthouse.Books.RepositoryTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Books.Book
  alias Lighthouse.Books.Repository

  test "save a book to the database" do
    book = sample_book()
    saved_book = Repository.save(book)

    assert saved_book.slug == "that-book"
  end

  test "can find a book by partial title" do
    Repository.save(sample_book())
    result = Repository.search("book")
    assert Enum.count(result) == 1
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
    %Book{
      isbn:  "1234",
      title: "That book",
      slug:  "that-book",
      description: "Its pretty cool.",
      link:  "http://example.com/books/that-book"
    }
  end
end
