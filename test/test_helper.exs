ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Faros.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Faros.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Faros.Repo)

