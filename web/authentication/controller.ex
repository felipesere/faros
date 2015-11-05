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
    {:ok, token} =  Github.get_token(code)
    IO.inspect token

    IO.inspect Github.get_user(token)

    redirect conn, to: "/"
  end
end
