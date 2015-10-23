defmodule Faros.Papers.ControllerTest do
  import Faros.SampleData, only: [sample_paper: 0]
  use Faros.ConnCase
  use Faros.RepositoryCase
  alias Faros.Repo
  alias Faros.Categories.Category
  alias Faros.Papers.Query

  test "renders all papers" do
    {:ok, paper} = sample_paper() |> Query.save
    conn = get conn(), "/papers"
    assert html_response(conn, 200) =~ paper.title
  end

  test "renders a specific paper" do
    {:ok, paper} = sample_paper() |> Query.save
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
    category = %Category{name: "marketing"} |> Repo.insert!

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

  test "can edit a paper" do
    {:ok, paper} = sample_paper() |> Query.save

    conn = get conn(), "/papers/#{paper.slug}/edit"

    assert html_response(conn, 200) =~ "/papers/#{paper.slug}/edit"
    assert html_response(conn, 200) =~ paper.title
  end

  test "can update a paper" do
    {:ok, paper} = sample_paper() |> Query.save

    conn = post conn(), "/papers/#{paper.slug}/edit", %{paper: %{title: "New Title"}}

    assert conn.status == 302
    assert html_response(conn, 302) =~ "papers/#{paper.slug}"
  end
end
