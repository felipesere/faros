defmodule Lighthouse.Health.Controller do
  use Lighthouse.Web, :controller
  require Git

  def check(conn, _params) do
    checks = %{ :database => db_check }
    status = to_status(checks)
    result = %{:sha => Git.last, :checks => checks}

    conn
    |> put_status(status)
    |> json(result)
  end

  def to_status(check) do
    check
    |> Enum.reduce(true, fn({_,value}, acc) -> acc && value end)
    |> case do
      true  -> 200
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
