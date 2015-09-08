defmodule Lighthouse.Categories.Repository do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Categories.Category
  alias Lighthouse.Categories.CategoryFor

  def save(category), do: Repo.insert!(category)

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
