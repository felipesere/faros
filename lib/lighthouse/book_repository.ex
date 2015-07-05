defmodule Lighthouse.BookRepository do
  use Ecto.Repo, otp_app: :lighthouse
  import Ecto.Query
  alias Lighthouse.Book

  def all() do
    all(from b in Book, select: b)
  end

  def find_by_slug(slug) do
    one(from b in Book,
         where: b.slug == ^slug,
         select: b) |> wrap
  end

  defp wrap(nil),    do: {:not_found, nil}
  defp wrap(entity), do: {:ok, entity}
end
