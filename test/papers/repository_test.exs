defmodule Lighthouse.Papers.RepositoryTest do
  import Lighthouse.SampleData, only: [sample_paper: 1, sample_paper: 0]
  use Lighthouse.RepositoryCase
  alias Lighthouse.Papers.Repository

  test "save a paper to the database" do
    paper = sample_paper()
    saved_paper = Repository.save(paper)
    assert saved_paper.title == paper.title
  end

  test "finds all papers" do
    sample_paper("the-first-book") |> Repository.save
    sample_paper("the-second-book") |> Repository.save

    assert Repository.all() |> Enum.count == 2
  end

  test "find a paper by slug" do
    paper = sample_paper() |> Repository.save
    assert Repository.find_by_slug(paper.slug)
  end

  test "can find a paper by partial title" do
    Repository.save(sample_paper())
    result = Repository.search("Fancy")
    assert Enum.count(result) == 1
  end

  test "can find a paper by partial author" do
    Repository.save(sample_paper())
    result = Repository.search("Esquire")
    assert Enum.count(result) == 1
  end
end
