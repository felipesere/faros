defmodule Faros.Papers.Controller do
  use Faros.Web, :controller
  alias Faros.Repo
  alias Faros.Papers.Query
  alias Faros.Papers.Paper
  alias Faros.Categories.Repository, as: CategoryRepo

  def index(conn, _) do
    render conn, "index.html", papers: Query.all()
  end

  def show(conn, %{"slug" => slug}) do
    paper = Query.find_by_slug(slug)
    categories = CategoryRepo.find_categories_for(paper)

    render conn, "show.html", paper: paper, categories: categories
  end

  def create(conn, %{"paper" => params, "category" => category}) do
    paper = %Paper{} |> Paper.changeset(params) |> Repo.insert!

    CategoryRepo.save_relation(category, paper)

    redirect conn, to: "/papers"
  end

  def create(conn, %{"paper" => params}) do
    %Paper{} |> Paper.changeset(params) |> Repo.insert!

    redirect conn, to: "/papers"
  end

  def add(conn, _) do
    render conn, "create.html"
  end
end
