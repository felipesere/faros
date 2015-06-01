defmodule Lighthouse.Books.Repository do
  @books [
    %{isbn: "1234567890123", title: "How to Ruby"}
  ]

  def all(), do: @books
end
