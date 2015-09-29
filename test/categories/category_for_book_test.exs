defmodule Lighthouse.Categories.CategoryForBookTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Categories.Category
  alias Lighthouse.Categories.CategoryFor

  test "saves a relation to a book" do
    book = Lighthouse.SampleData.sample_book  |> Repo.insert!
    category = %Category{name: "my-category"} |> Repo.insert!

    CategoryFor.save_relation(book, category)

    assert CategoryFor.find_categories_for(book) == [category]
  end
end
