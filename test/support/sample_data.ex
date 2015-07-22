defmodule Lighthouse.SampleData do
  alias Lighthouse.Books.Book
  alias Lighthouse.Papers.Paper

  def sample_paper do
    sample_paper("My Fancy Paper")
  end

  def sample_book do
    sample_book("That book")
  end

  def sample_book(title) do
    %Book{
      isbn:  "1234",
      title: title,
      slug:  "that-book",
      description: "Its pretty cool.",
      link:  "http://example.com/books/that-book"
    }
  end

  def sample_paper(title) do
    %Paper{
      title: title,
      author: "Mister Doctor Esquire",
      slug: "my-fancy-paper",
      description: "My research from 1845",
      link: "www.fancy-paper-r-us.com/fancy-paper"
    }
  end
end
