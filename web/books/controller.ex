defmodule Lighthouse.Books.Controller do
  use Lighthouse.Web, :controller
  plug :action

  alias Lighthouse.Books.Repository

  def index(conn, _params) do
    conn
    |> assign(:books, Repository.all())
    |> render "index.html"
  end
end
