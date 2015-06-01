defmodule Lighthouse.Books.Repository do
  @books [
    %{isbn: "1234567890123", title: "How to Ruby"},
    %{isbn: "1234567890124", title: "How to Python"}
  ]

  def all(), do: @books

  def find_by_isbn(isbn) do
    Enum.find(@books, fn (book) -> book[:isbn] == isbn end)
  end
end
