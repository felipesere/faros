defmodule Faros.Search.SearchTest do
  use Faros.RepositoryCase
  import Faros.SampleData, only: [sample_paper: 1, sample_book: 1]
  alias Faros.Searcher
  alias Faros.Books.Query
  alias Faros.Papers.Query, as: PapersQuery

  test "reutrns nothing if it can't be found" do
    result = Searcher.look_for("something")
    assert Enum.empty?(result)
  end

  test "can find a given book by title" do
    {:ok, book} = sample_book("That book") |> Query.save

    result = Searcher.look_for(book.title)
    assert Enum.count(result) == 1
  end

  test "finds only books with keyword in title" do
    {:ok, book} = sample_book("That book") |> Query.save
    sample_book("Not it") |> Query.save

    result = Searcher.look_for(book.title)
    assert Enum.count(result) == 1
  end

  test "finds both books and papers" do
    sample_book("Nothing")     |> Query.save
    sample_book("That Cloud")  |> Query.save
    sample_paper("Some Cloud") |> PapersQuery.save

    result = Searcher.look_for("Cloud")
    assert Enum.count(result) == 2
  end
end
