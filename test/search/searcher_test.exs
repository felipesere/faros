defmodule Lighthouse.Search.SearchTest do
  use Lighthouse.RepositoryCase
  import Lighthouse.SampleData, only: [sample_paper: 1,
                                       sample_book: 1]
  alias Lighthouse.Books.Repository, as: BooksRepo
  alias Lighthouse.Papers.Repository, as: PapersRepo
  alias Lighthouse.Searcher

  test "reutrns nothing if it can't be found" do
    result = Searcher.look_for("something")
    assert Enum.empty?(result)
  end

  test "can find a given book by title" do
    BooksRepo.save(sample_book("That book"))

    result = Searcher.look_for("That book")
    assert Enum.count(result) == 1
  end

  test "finds only books with keyword in title" do
    BooksRepo.save(sample_book("That book"))
    BooksRepo.save(sample_book("Not it"))

    result = Searcher.look_for("That book")
    assert Enum.count(result) == 1
  end

  test "finds both books and papers" do
    BooksRepo.save(sample_book("nothing"))
    BooksRepo.save(sample_book("That Cloud"))
    PapersRepo.save(sample_paper("Some Cloud"))

    result = Searcher.look_for("Cloud")
    assert Enum.count(result) == 2
  end
end
