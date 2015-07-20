defmodule Lighthouse.Books.Book do
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
  end
end
