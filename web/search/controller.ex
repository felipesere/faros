defmodule Lighthouse.Search.Controller do
  use Lighthouse.Web, :controller
  alias Lighthouse.Searcher

  def index(conn, %{"query" => query}) do
    results = Searcher.look_for(query)

    render conn, "index.html", results: results
  end
end
