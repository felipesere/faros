defmodule Faros.Search.SearchTest do
  use Faros.RepositoryCase
  import Faros.SampleData, only: [sample_paper: 1, sample_book: 1]
  alias Faros.Searcher

  test "reutrns nothing if it can't be found" do
    result = Searcher.look_for("something")
    assert Enum.empty?(result)
  end

  test "can find a given book by title" do
    book = sample_book("That book") |> Repo.insert!

    result = Searcher.look_for(book.title)
    assert Enum.count(result) == 1
  end

  test "finds only books with keyword in title" do
    book = sample_book("That book") |> Repo.insert!
    sample_book("Not it") |> Repo.insert!

    result = Searcher.look_for(book.title)
    assert Enum.count(result) == 1
  end

  test "finds both books and papers" do
    sample_book("Nothing")     |> Repo.insert!
    sample_book("That Cloud")  |> Repo.insert!
    sample_paper("Some Cloud") |> Repo.insert!

    result = Searcher.look_for("Cloud")
    assert Enum.count(result) == 2
  end
end
