defmodule Lighthouse.Papers.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Papers.Repository
  alias Lighthouse.Papers.Paper

  def index(conn, _params) do
    conn
    |> assign(:papers, Repository.all())
    |> render "index.html"
  end

  def show(conn, %{"slug" => slug}) do
    paper = Repository.find_by_slug(slug)

    conn
    |> assign(:paper, paper)
    |> render "show.html"
  end

  def add(conn, %{"paper" => params}) do
    Paper.changeset(%Paper{}, params)
    |> Repository.save

    redirect conn, to: "/papers"
  end
end
