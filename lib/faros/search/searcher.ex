defmodule Faros.Searcher do
  alias Faros.Books.Query, as: Books
  alias Faros.Papers.Query, as: Papers

  def look_for(keyword) do
    Books.search(keyword) ++ Papers.search(keyword)
  end
end

