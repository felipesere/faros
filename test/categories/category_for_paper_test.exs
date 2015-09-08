defmodule Lighthouse.Categories.CategoryForPaperTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Categories.Repository
  alias Lighthouse.Categories.Category
  alias Lighthouse.Categories.CategoryFor

  alias Lighthouse.Papers.Repository, as: PaperRepository

  test "saves a relation to a paper" do
    paper = PaperRepository.save(Lighthouse.SampleData.sample_paper)
    category = Repository.save(%Category{name: "my-category"})

    CategoryFor.save_relation(paper, category)

    assert CategoryFor.find_categories_for(paper) == [category]
  end
end
