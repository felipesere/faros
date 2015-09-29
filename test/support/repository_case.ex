defmodule Faros.RepositoryCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Faros.Repo
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Faros.Repo, [])
    end

    :ok
  end
end
