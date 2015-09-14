defmodule Lighthouse.Papers.RepositoryTest do
  import Lighthouse.SampleData, only: [sample_paper: 0]
  use Lighthouse.RepositoryCase
  alias Lighthouse.Papers.Repository

  test "finds all papers" do
    sample_paper() |> Repo.insert!
    sample_paper() |> Repo.insert!

    assert Repository.all() |> Enum.count == 2
  end

  test "find a paper by slug" do
    paper = sample_paper() |> Repo.insert!
    assert Repository.find_by_slug(paper.slug)
  end

  test "can find a paper by partial title" do
    paper = sample_paper() |> Repo.insert!
    result = Repository.search(paper.title)
    assert Enum.count(result) == 1
  end

  test "can find a paper by partial author" do
    paper = sample_paper() |> Repo.insert!
    result = Repository.search(paper.author)
    assert Enum.count(result) == 1
  end
end
