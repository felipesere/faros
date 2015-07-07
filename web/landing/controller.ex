defmodule Lighthouse.Landing.Controller do
  use Lighthouse.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
