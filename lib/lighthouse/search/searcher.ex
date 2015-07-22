defmodule Lighthouse.Searcher do
  alias Lighthouse.Books.Repository,  as: Books
  alias Lighthouse.Papers.Repository, as: Papers

  def look_for(keyword) do
    Books.search(keyword) ++ Papers.search(keyword)
  end
end

