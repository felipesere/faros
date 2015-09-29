defmodule Faros.Categories.CategoryForBookTest do
  use Faros.RepositoryCase
  alias Faros.Categories.Category
  alias Faros.Categories.CategoryFor

  test "saves a relation to a book" do
    book = Faros.SampleData.sample_book  |> Repo.insert!
    category = %Category{name: "my-category"} |> Repo.insert!

    CategoryFor.save_relation(book, category)

    assert CategoryFor.find_categories_for(book) == [category]
  end
end
