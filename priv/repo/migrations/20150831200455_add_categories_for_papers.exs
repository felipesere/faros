defmodule Faros.Repo.Migrations.AddCategoriesForPapers do
  use Ecto.Migration

  def change do
    create table(:categories_for_papers) do
      add :category_id, references(:categories)
      add :paper_id,     references(:papers)
    end
  end
end
