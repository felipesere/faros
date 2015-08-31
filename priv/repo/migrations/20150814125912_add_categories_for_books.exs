defmodule Lighthouse.Repo.Migrations.AddCategoriesForBooks do
  use Ecto.Migration

  def change do
    create table(:categories_for_books) do
      add :category_id, references(:categories)
      add :book_id,     references(:books)
    end
  end
end
