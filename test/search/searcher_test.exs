defmodule Lighthouse.Search.SearchTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Books.Repository, as: BooksRepo
  alias Lighthouse.Books.Book
  alias Lighthouse.Papers.Repository, as: PapersRepo
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Searcher

  test "reutrns nothing if it can't be found" do
    result = Searcher.look_for("something")
    assert Enum.empty?(result)
  end

  test "can find a given book by title" do
    BooksRepo.save(book_with_title("That book"))

    result = Searcher.look_for("That book")
    assert Enum.count(result) == 1
  end

  test "finds only books with keyword in title" do
    BooksRepo.save(book_with_title("That book"))
    BooksRepo.save(book_with_title("Not it"))

    result = Searcher.look_for("That book")
    assert Enum.count(result) == 1
  end

  test "finds both books and papers" do
    BooksRepo.save(book_with_title("nothing"))
    BooksRepo.save(book_with_title("That Cloud"))
    PapersRepo.save(paper_with_title("Some Cloud"))

    result = Searcher.look_for("Cloud")
    assert Enum.count(result) == 2
  end

  def book_with_title(title) do
    %Book{
      isbn:  "1234",
      title: title,
      slug:  "that-book",
      description: "Its pretty cool.",
      link:  "http://example.com/books/that-book"
    }
  end

  def paper_with_title(title) do
    %Paper{
      title: title,
      author: "Mister Doctor Esquire",
      slug: "my-fancy-paper",
      description: "My research from 1845",
      link: "www.fancy-paper-r-us.com/fancy-paper"
    }
  end
end
