defmodule Lighthouse.Categories.RepositoryTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Categories.Repository
  alias Lighthouse.Categories.Category

  test "saves a category" do
    category = Repository.save(%Category{name: "my-category"})
    assert category.name == "my-category"
  end

  defimpl Lighthouse.Categories.CategoryFor, for: Integer do
    def save_relation(thing, name), do: {thing, name}
    def find_categories_for(thing), do: thing
  end

  test "saves a relation" do
    category = Repository.save(%Category{name: "my-category"})

    assert Repository.save_relation(category.name, 1) == {1, category}
  end

  test "retrieves categories" do
    assert Repository.find_categories_for(1) == 1
  end
end
