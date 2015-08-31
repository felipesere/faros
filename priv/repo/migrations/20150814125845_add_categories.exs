defmodule Lighthouse.Repo.Migrations.AddCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
    end
  end
end
