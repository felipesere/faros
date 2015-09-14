defmodule Lighthouse.Papers.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Repo
  alias Lighthouse.Papers.Repository
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Categories.Repository, as: CategoryRepo

  def index(conn, _) do
    render conn, "index.html", papers: Repository.all()
  end

  def show(conn, %{"slug" => slug}) do
    paper = Repository.find_by_slug(slug)
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
