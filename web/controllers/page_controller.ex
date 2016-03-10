defmodule Faros.PageController do
  use Faros.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def styleguide(conn, _params) do
    render conn, "styleguide.html"
  end

  def path_step(conn, _params) do
    render conn, "path_step.html"
  end
end
