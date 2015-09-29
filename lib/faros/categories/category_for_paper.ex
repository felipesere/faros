defimpl Faros.Categories.CategoryFor, for: Faros.Papers.Paper do
  import Ecto.Query
  alias Faros.Repo
  alias Faros.Papers.Paper
  alias Faros.Categories.Category
  alias Faros.Categories.CategoriesForPaper

  def save_relation(%Paper{id: paper_id}, %Category{id: category_id}) do
    %CategoriesForPaper{category_id: category_id, paper_id: paper_id}
    |> Repo.insert!
  end

  def find_categories_for(%Paper{id: paper_id}) do
    query = from p in Paper,
            join: cfp in CategoriesForPaper, on: p.id == cfp.paper_id,
            join: c in Category, on: c.id == cfp.category_id,
            where: p.id == ^paper_id,
            select: c

    Repo.all(query)
  end
end
