defmodule Lighthouse.Papers.ControllerTest do
  import Lighthouse.SampleData, only: [sample_paper: 0]
  use Lighthouse.ConnCase
  use Lighthouse.RepositoryCase
  alias Lighthouse.Papers.Repository
  alias Lighthouse.Categories.Repository, as: CategoryRepo
  alias Lighthouse.Categories.Category

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

  test "has form to add paper" do
    conn = get conn(), "/papers/add"
    assert html_response(conn, 200)
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

  test "adds a paper with a category" do
    category = CategoryRepo.save(%Category{name: "marketing"})

    params = %{
      "title"       => "a",
      "author"      => "b",
      "slug"        => "abc",
      "description" => "d",
      "link"        => "e"
    }

    post conn(), "/papers", %{"paper" => params, "category": category.name}

    conn = get conn(), "/papers/#{params["slug"]}"
    assert html_response(conn, 200) =~ category.name
  end
end
