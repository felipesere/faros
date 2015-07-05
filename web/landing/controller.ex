defmodule Lighthouse.Landing.Controller do
  use Lighthouse.Web, :controller
  plug :action

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
