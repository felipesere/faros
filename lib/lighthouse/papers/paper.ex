defmodule Lighthouse.Papers.Paper do
  use Ecto.Model

  schema "papers" do
    field :title
    field :author
    field :slug
    field :description
    field :link
  end

  @required_fields ~w(title author slug description link)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> unique_constraint(:slug)
  end
end
