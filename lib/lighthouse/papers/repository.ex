defmodule Lighthouse.Papers.Repository do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Papers.Paper

  def all, do: Repo.all(from p in Paper, select: p)

  def save(paper), do: Repo.insert!(paper)

  def find_by_slug(slug) do
    query = from p in Paper, where: p.slug == ^slug, select: p
    Repo.one(query)
  end
end