defmodule Faros.Books.View do
  use Faros.Web, :view

  def errors(form) do
    render(Faros.SharedView, "errors.html", form: form)
  end

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

  def slug(changeset) do
    Ecto.Changeset.get_field(changeset, :slug)
  end

  def title(changeset) do
    changeset.model.title
  end
end
