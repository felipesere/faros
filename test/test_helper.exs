ExUnit.start

# Create the database, run migrations, and start the test transaction.
Mix.Task.run "ecto.create",  ["--quiet", "-r", "Lighthouse.BookRepository"]
Mix.Task.run "ecto.migrate", ["--quiet", "-r", "Lighthouse.BookRepository"]
#Ecto.Adapters.SQL.begin_test_transaction(Lighthouse.BookRepository)
