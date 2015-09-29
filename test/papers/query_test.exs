defmodule Faros.Papers.QueryTest do
  import Faros.SampleData, only: [sample_paper: 0, sample_paper: 1]
  use Faros.RepositoryCase
  alias Faros.Papers.Query

  test "finds all papers" do
    sample_paper("the-first") |> Query.save
    sample_paper("the-second") |> Query.save

    assert Query.all() |> Enum.count == 2
  end

  test "slug has to be unique" do
    {:ok, _ } = sample_paper("the-first") |> Query.save
    {:error, changeset} = sample_paper("the-first") |> Query.save
    assert changeset.errors[:slug]
  end

  test "find a paper by slug" do
    {:ok, paper} = sample_paper() |> Query.save
    assert Query.find_by_slug(paper.slug)
  end

  test "can find a paper by partial title" do
    {:ok, paper} = sample_paper() |> Query.save
    result = Query.search(paper.title)
    assert Enum.count(result) == 1
  end

  test "can find a paper by partial author" do
    {:ok, paper} = sample_paper() |> Query.save
    result = Query.search(paper.author)
    assert Enum.count(result) == 1
  end
end