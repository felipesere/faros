defmodule Lighthouse.RepositoryCase do
  use ExUnit.CaseTemplate

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Lighthouse.Repo, [])
    end

    :ok
  end
end
