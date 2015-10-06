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
    |> validate_length(:title, min: 3)
    |> validate_format(:link, ~r/http:\/\//)
    |> unique_constraint(:slug)
  end
end
