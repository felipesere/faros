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
