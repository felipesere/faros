defmodule Lighthouse.Categories.CategoryForPaperTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Categories.Category
  alias Lighthouse.Categories.CategoryFor

  test "saves a relation to a paper" do
    paper = Lighthouse.SampleData.sample_paper |> Repo.insert!
    category = %Category{name: "my-category"}  |> Repo.insert!

    CategoryFor.save_relation(paper, category)

    assert CategoryFor.find_categories_for(paper) == [category]
  end
end
