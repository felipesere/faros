defmodule Faros.Books.Book do
  use Ecto.Model

  schema "books" do
    field :isbn
    field :title
    field :slug
    field :description
    field :link
  end

  @required_fields ~w(title description isbn slug link)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> normalize
    |> validate_format(:isbn, ~r/[\d]{13}/)
    |> validate_length(:isbn, is: 13)
    |> validate_length(:title, min: 3)
    |> validate_format(:link, ~r/http:\/\//)
    |> validate_length(:slug, min: 5)
    |> unique_constraint(:slug)
  end

  defp normalize(changeset = %Ecto.Changeset{changes: changes}) do
    %{changeset | changes: normalize_isbn(changes)}
  end

  def normalize_isbn(changes = %{isbn: isbn} ) do
    %{changes | isbn: String.replace(isbn, ~r/[^\w]/,"")}
  end
  def normalize_isbn(x), do: x
end
