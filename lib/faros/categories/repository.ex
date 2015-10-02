defmodule Faros.Categories.Repository do
  import Ecto.Query
  alias Faros.Repo
  alias Faros.Categories.Category
  alias Faros.Categories.CategoryFor

  def save(data) do
    {:ok, category} = %Category{} |> Category.changeset(data) |> Repo.insert
  end

  def all do
    query = from c in Category, select: c
    Repo.all(query)
  end

  def save_relation(category_name, thing) do
    category = find_by_name(category_name)
    CategoryFor.save_relation(thing, category)
  end

  def find_categories_for(thing) do
    CategoryFor.find_categories_for(thing)
  end

  defp find_by_name(name) do
    query = from c in Category, where: c.name == ^name, select: c
    Repo.one(query)
  end
end
