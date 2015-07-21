defmodule Lighthouse.Papers.ControllerTest do
  use Lighthouse.ConnCase
  use Lighthouse.RepositoryCase
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Papers.Repository

  test "renders all papers" do
    paper = Repository.save(sample_paper())
    conn = get conn(), "/papers"
    assert html_response(conn, 200) =~ paper.title
  end

  test "renders a specific paper" do
    paper = Repository.save(sample_paper())
    conn = get conn(), "/papers/#{paper.slug}"
    assert html_response(conn, 200) =~ paper.title
  end

  test "adds a paper" do
    params = %{
      "title"       => "a",
      "author"      => "b",
      "slug"        => "abc",
      "description" => "d",
      "link"        => "e"
    }
    conn = post conn(), "/papers", %{"paper" => params}
    assert html_response(conn, 302)

    conn = get conn(), "/papers/#{params["slug"]}"
    assert html_response(conn, 200)
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
