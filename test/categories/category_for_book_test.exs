defmodule Lighthouse.Categories.CategoryForBookTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Categories.Repository
  alias Lighthouse.Categories.Category
  alias Lighthouse.Categories.CategoryFor

  alias Lighthouse.Books.Repository, as: BookRepository

  test "saves a relation to a book" do
    book = BookRepository.save(Lighthouse.SampleData.sample_book)
    category = Repository.save(%Category{name: "my-category"})

    CategoryFor.save_relation(book, category)

    assert CategoryFor.find_categories_for(book) == [category]
  end
end
