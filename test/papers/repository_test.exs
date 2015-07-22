defmodule Lighthouse.Papers.RepositoryTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Papers.Repository

  test "save a paper to the database" do
    paper = sample_paper()
    saved_paper = Repository.save(paper)
    assert saved_paper.title == paper.title
  end

  test "finds all papers" do
    sample_paper() |> Repository.save
    sample_paper() |> Repository.save

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

  def sample_paper do
    %Paper{
      title: "My Fancy Paper",
      author: "Mister Doctor Esquire",
      slug: "my-fancy-paper",
      description: "My research from 1845",
      link: "www.fancy-paper-r-us.com/fancy-paper"
    }
  end
end
