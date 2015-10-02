defmodule Faros.Categories.CategoryForPaperTest do
  use Faros.RepositoryCase
  alias Faros.Categories.Category
  alias Faros.Categories.CategoryFor

  test "saves a relation to a paper" do
    paper = Faros.SampleData.sample_paper |> Repo.insert!
    category = %Category{name: "my-category"}  |> Repo.insert!

    CategoryFor.save_relation(paper, category)

    assert CategoryFor.find_categories_for(paper) == [category]
  end
end
