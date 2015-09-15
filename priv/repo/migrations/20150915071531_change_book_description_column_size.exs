defmodule Lighthouse.Repo.Migrations.ChangeBookDescriptionColumnSize do
  use Ecto.Migration

  def change do
    alter table(:books) do
      modify :description, :text
    end
  end
end
