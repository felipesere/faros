defmodule Lighthouse.Papers.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Papers.Repository

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
end
