defmodule Faros.Authentication.Controller do
  use Faros.Web, :controller
  alias Faros.Github

  def index(conn,_params) do
    render conn, "index.html"
  end

  def github(conn, _params) do
    redirect conn, external: Github.authorization_url()
  end

  def callback(conn, %{ "code" => code, "state" => state}) do
    IO.inspect Github.get_token(code)
    redirect conn, to: "/"
  end
end
