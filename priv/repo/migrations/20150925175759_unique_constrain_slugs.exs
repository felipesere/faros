defmodule Lighthouse.Repo.Migrations.UniqueConstrainSlugs do
  use Ecto.Migration

  def change do
    create unique_index(:books,  [:slug])
    create unique_index(:papers, [:slug])
  end
end
