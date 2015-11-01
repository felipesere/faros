defmodule Faros.Authentication.Controller do
  use Faros.Web, :controller

  def index(conn,_params) do
    render conn, "index.html"
  end

  def github(conn, _params) do
    redirect conn, external: authorization_url()
  end

  defp authorization_url() do
    "https://github.com/login/oauth/authorize?client_id=#{client_id!()}&scope=user:email&state=abc"
  end

  defp client_id!() do
    System.get_env("GITHUB_CLIENT_ID") || raise "Missing Github client id"
  end
end
