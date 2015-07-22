defmodule Lighthouse.Search.ControllerTest do
  use Lighthouse.ConnCase
  use Lighthouse.RepositoryCase
  alias Lighthouse.Books.Book
  alias Lighthouse.Books.Repository, as: Books
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Papers.Repository, as: Papers

  test "finds both books and papers" do
    Books.save(book_with_title("That Cloud"))
    Papers.save(paper_with_title("Some Cloud"))

    conn = post conn(), "/search", %{"query" => "cloud" }
    response = html_response(conn, 200)

    assert response =~ "That Cloud"
    assert response =~ "Some Cloud"
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
