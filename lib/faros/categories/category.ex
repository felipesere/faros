defmodule Faros.Categories.Category do
  use Ecto.Model

  schema "categories" do
    field :name
  end

  @required_fields ~w(name)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
  end
end
