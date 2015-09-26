defmodule Lighthouse.Papers.Repository do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Slugger

  def all, do: Repo.all(from p in Paper, select: p)

  def save(paper) do
    Paper.changeset(%Paper{}, paper)
    |> Repo.insert
  end

  def find_by_slug(slug) do
    query = from p in Paper, where: p.slug == ^slug, select: p
    Repo.one(query)
  end

  def search(keyword) do
    wrapped = "%#{keyword}%"
    query = from p in Paper, where: like(p.title,  ^wrapped)
                                 or like(p.author, ^wrapped), select: p
    Repo.all(query)
  end
end
