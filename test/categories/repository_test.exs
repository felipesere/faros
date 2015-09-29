defmodule Faros.Categories.RepositoryTest do
  use Faros.RepositoryCase
  alias Faros.Categories.Repository
  alias Faros.Categories.Category

  defimpl Faros.Categories.CategoryFor, for: Integer do
    def save_relation(thing, name), do: {thing, name}
    def find_categories_for(thing), do: thing
  end

  test "saves a relation" do
    category = %Category{name: "my-category"} |> Repo.insert!

    assert Repository.save_relation(category.name, 1) == {1, category}
  end

  test "retrieves categories" do
    assert Repository.find_categories_for(1) == 1
  end
end
