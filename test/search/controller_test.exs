defmodule Lighthouse.Search.ControllerTest do
  import Lighthouse.SampleData, only: [sample_paper: 1,
                                       sample_book: 1]
  use Lighthouse.ConnCase
  use Lighthouse.RepositoryCase
  alias Lighthouse.Books.Repository, as: Books
  alias Lighthouse.Papers.Repository, as: Papers

  test "finds both books and papers" do
    Books.save(sample_book("That Cloud"))
    Papers.save(sample_paper("Some Cloud"))

    conn = post conn(), "/search", %{"query" => "cloud" }
    response = html_response(conn, 200)

    assert response =~ "That Cloud"
    assert response =~ "Some Cloud"
  end
end
