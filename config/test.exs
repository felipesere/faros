use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :faros, Faros.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :faros, :book_finder, Faros.Books.FakeFinder

config :faros, Faros.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "faros_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  size: 1 # Use a single connection for transactional tests
