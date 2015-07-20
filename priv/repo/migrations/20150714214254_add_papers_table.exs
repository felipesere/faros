defmodule Lighthouse.Repo.Migrations.AddPapersTable do
  use Ecto.Migration

  def change do
    create table(:papers) do
      add :title,       :string
      add :description, :string
      add :author,      :string
      add :slug,        :string
      add :link,        :string
    end
  end
end
