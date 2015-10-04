defmodule Faros.Categories.CategoryForBookTest do
  use Faros.RepositoryCase
  alias Faros.Categories.Category
  alias Faros.Categories.CategoryFor
  alias Faros.Books.Query
  import Faros.SampleData, only: [sample_book: 0]

  test "saves a relation to a book" do
    {:ok, book} = sample_book()  |> Query.save
    category = %Category{name: "my-category"} |> Repo.insert!

    CategoryFor.save_relation(book, category)

    assert CategoryFor.find_categories_for(book) == [category]
  end
end
