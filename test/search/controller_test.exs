defmodule Faros.Search.ControllerTest do
  import Faros.SampleData, only: [sample_paper: 1, sample_book: 1]
  use Faros.ConnCase
  use Faros.RepositoryCase

  test "finds both books and papers" do
    sample_book("That Cloud")  |> Repo.insert!
    sample_paper("Some Cloud") |> Repo.insert!

    conn = post conn(), "/search", %{"query" => "cloud" }
    response = html_response(conn, 200)

    assert response =~ "That Cloud"
    assert response =~ "Some Cloud"
  end
end
