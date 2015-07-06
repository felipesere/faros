defmodule Lighthouse.BookRepository.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :isbn
      add :title
      add :slug
      add :description
      add :link
    end
  end
end
