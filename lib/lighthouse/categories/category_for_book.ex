defimpl Lighthouse.Categories.CategoryFor, for: Lighthouse.Books.Book do
  import Ecto.Query
  alias Lighthouse.Repo
  alias Lighthouse.Books.Book
  alias Lighthouse.Categories.Category
  alias Lighthouse.Categories.CategoriesForBook

  def save_relation(%Book{id: book_id}, %Category{id: category_id}) do
    relation = %CategoriesForBook{category_id: category_id, book_id: book_id}

    Repo.insert!(relation)
  end

  def find_categories_for(%Book{id: book_id}) do
    query = from b in Book,
            join: cfb in CategoriesForBook, on: b.id == cfb.book_id,
            join: c in Category, on: c.id == cfb.category_id,
            where: b.id == ^book_id,
            select: c

    Repo.all(query)
  end
end
