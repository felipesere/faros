defmodule Lighthouse.Papers.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Papers.Repository
  alias Lighthouse.Papers.Paper
  alias Lighthouse.Categories.Repository, as: CategoryRepo

  def index(conn, _params) do
    conn
    |> assign(:papers, Repository.all())
    |> render "index.html"
  end

  def show(conn, %{"slug" => slug}) do
    paper = Repository.find_by_slug(slug)
    categories = CategoryRepo.find_categories_for(paper)

    conn
    |> assign(:paper, paper)
    |> assign(:categories, categories)
    |> render "show.html"
  end

  def create(conn, %{"paper" => params, "category" => category}) do
    paper = %Paper{} |> Paper.changeset(params) |> Repository.save

    CategoryRepo.save_relation(category, paper)

    redirect conn, to: "/papers"
  end

  def create(conn, %{"paper" => params}) do
    Paper.changeset(%Paper{}, params)
    |> Repository.save

    redirect conn, to: "/papers"
  end

  def add(conn, _params) do
    conn
    |> render "create.html"
  end
end
