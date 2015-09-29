defmodule Faros.Categories.CategoriesForBook do
  use Ecto.Model

  schema "categories_for_books" do
    field :category_id, :integer
    field :book_id,     :integer
  end
end
