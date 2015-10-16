defmodule Faros.Books.FinderFake do

  def find_by_isbn(isbn) do
    {:ok,
      %{
        title: "A Book",
        isbn: isbn
      }
    }
  end
end
