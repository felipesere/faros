defmodule Faros.Elm.Controller do
  use Faros.Web, :controller

  plug :put_layout, "elm_app.html"

  def index(conn, _) do
    render conn
  end
end
