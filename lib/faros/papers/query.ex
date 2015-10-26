defmodule Faros.Papers.Query do
  import Ecto.Query
  alias Faros.Repo
  alias Faros.Papers.Paper

  def all, do: Repo.all(from p in Paper, select: p)

  def save(paper_data) do
    %Paper{}
    |> Paper.changeset(paper_data)
    |> Repo.insert
  end

  def find_by_slug(slug) do
    query = from p in Paper, where: p.slug == ^slug, select: p
    Repo.one(query)
  end

  def search(keyword) do
    wrapped = "%#{keyword}%"
    query =
      from p in Paper,
      where: like(p.title,  ^wrapped) or like(p.author, ^wrapped),
      select: p
    Repo.all(query)
  end

  def update(paper, data) do
    paper
    |> Paper.changeset(data)
    |> Repo.update
  end
end
