defmodule Faros.Books.ValidationTest do
  use ExUnit.Case
  alias Faros.Books.Book
  import Faros.SampleData, only: [sample_book: 0]

  test "a book with a blank title is invalid" do
    changeset = Book.changeset(%Book{}, %{sample_book() | title: ""})
    refute changeset.valid?
  end

  test "a book with an ill-formated url is invalid" do
    changeset = Book.changeset(%Book{}, %{sample_book() | link: "not-really-a-url"})
    refute changeset.valid?
  end

  test "ISBNs are normalized before saving" do
    changeset = Book.changeset(%Book{}, %{sample_book() | isbn: "1234-5678-9012-3"})
    assert "1234567890123" == changeset.changes.isbn
  end

  test "an ISBN must have 13 characters to be valid" do
    short = Book.changeset(%Book{}, %{sample_book() | isbn: "123"})
    refute short.valid?

    long = Book.changeset(%Book{}, %{sample_book() | isbn: "12345-67890-12345"})
    refute long.valid?
  end

  test "ISBN can only contain numeric values" do
    changeset = Book.changeset(%Book{}, %{sample_book() | isbn: "123-456-789-abcd"})
    refute changeset.valid?
  end

  test "a book with a blank slug is invalid" do
    changeset = Book.changeset(%Book{}, %{sample_book() | slug: ""})
    refute changeset.valid?
  end
end
