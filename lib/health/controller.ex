defmodule Lighthouse.Health.Controller do
  use Lighthouse.Web, :controller

  def check(conn, _params) do
    result = %{ :database => db_check }
    status = to_status(result)

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
