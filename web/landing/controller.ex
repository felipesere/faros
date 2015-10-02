defmodule Faros.Landing.Controller do
  use Faros.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
