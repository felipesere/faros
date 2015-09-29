defmodule Lighthouse.Books.Query do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Books.Book

  def all, do: Repo.all(from b in Book, select: b)

  def find_by_slug(slug) do
    query = from b in Book, where: b.slug == ^slug, select: b

    Repo.one(query)
  end

  def update_book(book, data) do
    book
    |> Book.changeset(data)
    |> Repo.update!
  end

  def search(keyword) do
    wrapped = "%#{keyword}%"
    query = from b in Book, where: like(b.title, ^wrapped), select: b
    Repo.all(query)
  end
end