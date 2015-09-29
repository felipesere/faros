defmodule Faros.Books.IsbnLookupFake do

  def find_by_isbn(_) do
    %{
      title: "A Book"
    }
  end
end
