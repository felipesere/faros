defmodule Faros.Books.View do
  use Faros.Web, :view

  def render("lookup.json", %{book: book}) do
    %{book: book}
  end

  def style(%Ecto.Changeset{ errors: errors }, field) do
    if errors[field] do
      "error-value"
    else
      ""
    end
  end
end
