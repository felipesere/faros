defmodule Faros.Categories.Controller do
  use Faros.Web, :controller
  alias Faros.Categories.Repository

  def index(conn, _) do
    render conn, "index.html", categories: Repository.all()
  end

  def add(conn, %{"name" => name}) do
    Repository.save(%{name: name})

    redirect conn, to: "/categories"
  end
end
