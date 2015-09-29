defmodule Faros.Search.Controller do
  use Faros.Web, :controller
  alias Faros.Searcher

  def index(conn, %{"query" => query}) do
    results = Searcher.look_for(query)

    render conn, "index.html", results: results
  end
end
