defmodule Lighthouse.Search.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Books.Repository
  alias Lighthouse.Searcher

  def index(conn, %{"query" => query}) do
    results = Searcher.look_for(query)

    conn
    |> assign(:results, results)
    |> render "index.html"
  end
end
