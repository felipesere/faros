defmodule Lighthouse.Books.Repository do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Books.Book

  def all() do
    Repo.all(from b in Book, select: b)
  end

  def find_by_slug(slug) do
    Repo.one(from b in Book,
         where: b.slug == ^slug,
         select: b) |> wrap
  end

  def update_book(book, data) do
    book
    |> Book.changeset(data)
    |> Repo.update!
  end

  def delete_all do
    Repo.delete_all(Book)
  end

  def save(book) do
    Repo.insert!(book)
  end

  defp wrap(nil),    do: {:not_found, nil}
  defp wrap(entity), do: {:ok, entity}
end
