defmodule Lighthouse.Repo do
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

  defp wrap(entity) do
    case entity do
      nil  -> {:not_found, nil}
      _    -> {:ok, entity}
    end
  end
end
