defmodule Lighthouse.Searcher do
  alias Lighthouse.Books.Query, as: Books
  alias Lighthouse.Papers.Query, as: Papers

  def look_for(keyword) do
    Books.search(keyword) ++ Papers.search(keyword)
  end
end

