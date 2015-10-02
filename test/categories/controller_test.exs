defmodule Faros.Categories.ControllerTest do
  use Faros.ConnCase
  use Faros.RepositoryCase

  alias Faros.Categories.Category
  alias Faros.Categories.Repository

  test "renders all categories" do
    category_1 = %Category{name: "name1"} |> Repo.insert!
    category_2 = %Category{name: "name2"} |> Repo.insert!

    conn = get conn(), "/categories"
    assert html_response(conn, 200) =~ category_1.name
    assert html_response(conn, 200) =~ category_2.name
  end

  test "adds a category" do
    name = "Name"
    post conn(), "/categories", %{name: name}

    category_names = Repository.all() |> Enum.map(fn (category) -> category.name end)

    assert name in category_names
  end

  test "adding redirects to index" do
    conn = post conn(), "/categories", %{name: "name"}

    assert redirected_to(conn) == "/categories"
  end
end
