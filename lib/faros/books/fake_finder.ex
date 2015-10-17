defmodule Faros.Books.FakeFinder do
  alias Faros.SampleData

  def find_by_title(title) do
    {:ok, %{ SampleData.sample_book() | title: title} }
  end

  def find_by_isbn(isbn) do
    {:ok, %{ SampleData.sample_book() | isbn: isbn } }
  end
end
