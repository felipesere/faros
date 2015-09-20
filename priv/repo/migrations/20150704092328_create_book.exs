defmodule Lighthouse.BookRepository.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :isbn,        :string
      add :title,       :string
      add :slug,        :string
      add :description, :string
      add :link,        :string
    end
  end
end
