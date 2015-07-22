defmodule Lighthouse.Books.Repository do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Books.Book

  def all, do: Repo.all(from b in Book, select: b)

  def find_by_slug(slug) do
    query = from b in Book, where: b.slug == ^slug, select: b

    Repo.one(query)
    |> wrap
  end

  def update_book(book, data) do
    book
    |> Book.changeset(data)
    |> Repo.update!
  end

  def delete_all do
    Repo.delete_all(Book)
  end

  def search(keyword) do
    wrapped = "%#{keyword}%"
    query = from b in Book, where: like(b.title, ^wrapped), select: b
    Repo.all(query)
  end

  def save(book), do: Repo.insert!(book)

  defp wrap(nil),    do: {:not_found, nil}
  defp wrap(entity), do: {:ok, entity}
end
