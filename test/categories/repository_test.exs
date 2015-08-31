defmodule Lighthouse.Categories.RepositoryTest do
  use Lighthouse.RepositoryCase
  alias Lighthouse.Categories.Repository
  alias Lighthouse.Categories.Category

  alias Lighthouse.Books.Repository, as: BookRepository
  alias Lighthouse.Papers.Repository, as: PaperRepository

  test "saves a category" do
    category = Repository.save(%Category{name: "my-category"})
    assert category.name == "my-category"
  end

  test "saves a relation to a book" do
    book = BookRepository.save(Lighthouse.SampleData.sample_book)
    category = Repository.save(%Category{name: "my-category"})

    Repository.save_relation(category.name, book)

    assert Repository.find_categories_for(book) == [category]
  end

  test "saves a relation to a paper" do
    paper = PaperRepository.save(Lighthouse.SampleData.sample_paper)
    category = Repository.save(%Category{name: "my-category"})

    Repository.save_relation(category.name, paper)

    assert Repository.find_categories_for(paper) == [category]
  end
end
