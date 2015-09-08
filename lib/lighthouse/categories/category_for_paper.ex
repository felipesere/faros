defimpl Lighthouse.Categories.CategoryFor, for: Lighthouse.Papers.Paper do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Categories.Category
  alias Lighthouse.Categories.CategoriesForPaper

  def save_relation(%Paper{id: paper_id}, %Category{id: category_id}) do
    relation = %CategoriesForPaper{category_id: category_id, paper_id: paper_id}

    Repo.insert!(relation)
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
