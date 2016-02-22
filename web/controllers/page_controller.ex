defmodule Faros.PageController do
  use Faros.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def cj_styleguide(conn, _params) do
    render conn, "cj_styleguide.html"
  end
end
