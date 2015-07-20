defmodule Lighthouse.Papers.ControllerTest do
  use Lighthouse.ConnCase
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Papers.Repository

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Lighthouse.Repo, [])
    end

    sample_paper() |> Repository.save

    :ok
  end

  test "renders all papers" do
    conn = get conn(), "/papers"
    paper = Repository.all() |> List.first
    assert html_response(conn, 200) =~ paper.title
  end

  test "renders a specific paper" do
    paper = Repository.all() |> List.first
    conn = get conn(), "/papers/#{paper.slug}"
    assert html_response(conn, 200) =~ paper.title
  end

  def sample_paper do
    %Paper{
      title: "My Fancy Paper",
      author: "Mister Doctor Esquire",
      slug: "my-fancy-paper",
      description: "My research from 1845",
      link: "www.fancy-paper-r-us.com/fancy-paper"
    }
  end
end
