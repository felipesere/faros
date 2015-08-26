defmodule Lighthouse.Health.Controller do
  use Lighthouse.Web, :controller
  require Git

  @last_sha Git.last

  def check(conn, _params) do
    checks = %{ :database => db_check }
    status = to_status(checks)
    result = %{:sha => @last_sha, :checks => checks}

    conn
    |> put_status(status)
    |> json(result)
  end

  def to_status(results) do
    results
    |> Enum.reduce(true, fn({_,value}, acc) -> acc && value end)
    |> case do
      true -> 200
      false -> 500
    end
  end

  def db_check(repo \\ Lighthouse.Repo) do
    case Ecto.Storage.up(repo) do
      :ok -> true
      {:error, :already_up} -> true
      {:error, _} -> false
    end
  end
end
