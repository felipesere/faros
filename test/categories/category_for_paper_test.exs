defmodule Faros.Categories.CategoryForPaperTest do
  use Faros.RepositoryCase
  alias Faros.Categories.Category
  alias Faros.Categories.CategoryFor
  alias Faros.Papers.Query
  alias Faros.SampleData

  test "saves a relation to a paper" do
    {:ok, paper} = SampleData.sample_paper() |> Query.save
    category = %Category{name: "my-category"}  |> Repo.insert!

    CategoryFor.save_relation(paper, category)

    assert CategoryFor.find_categories_for(paper) == [category]
  end
end
