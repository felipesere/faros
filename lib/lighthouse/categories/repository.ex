defmodule Lighthouse.Categories.Repository do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Books.Book
  alias Lighthouse.Categories.Category
  alias Lighthouse.Categories.CategoriesForBook

  def save(category), do: Repo.insert!(category)

  def save_relation(category_name, %Book{id: book_id}) do
    %Category{id: category_id} = find_by_name(category_name)
    relation = %CategoriesForBook{category_id: category_id, book_id: book_id}

    Repo.insert!(relation)
  end

  defp find_by_name(name) do
    query = from c in Category, where: c.name == ^name, select: c
    Repo.one(query)
  end

  def find_categories_for(%Book{id: book_id}) do
    query = from b in Book,
            join: cfb in CategoriesForBook, on: b.id == cfb.book_id,
            join: c in Category, on: c.id == cfb.category_id,
            where: b.id == ^book_id,
            select: c

    Repo.all(query)
  end
end
