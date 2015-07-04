defmodule Lighthouse.Book do
  use Ecto.Model

  schema "books" do
    field :isbn
    field :title
    field :slug
    field :description
    field :link
  end
end
