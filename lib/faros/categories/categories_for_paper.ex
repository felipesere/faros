defmodule Faros.Categories.CategoriesForPaper do
  use Ecto.Model

  schema "categories_for_papers" do
    field :category_id, :integer
    field :paper_id,    :integer
  end
end
