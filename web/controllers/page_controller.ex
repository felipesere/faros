defmodule Faros.PageController do
  use Faros.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def styleguide(conn, _params) do
    render conn, "styleguide.html"
  end

  def path_step_1(conn, _params) do
    render conn, "path_step_1.html"
  end

  def path_step_4(conn, _params) do
    render conn, "path_step_4.html"
  end

  def path_step_6(conn, _params) do
    render conn, "path_step_6.html"
  end

  def path_step_7(conn, _params) do
    render conn, "path_step_7.html"
  end

  def path_overview(conn, _params) do
    render conn, "path_overview.html"
  end

  def progress(conn, _params) do
    render conn, "progress.html"
  end
end
