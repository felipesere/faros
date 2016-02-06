use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :faros, Faros.Endpoint,
  secret_key_base: "wtz8IuR3Bh0+e19r9Ddo7Dxpo72Qlf0dTQkFwyI5YImhHYNeODWH3lZJmlZhqqUt"

# Configure your database
config :faros, Faros.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "faros_prod",
  pool_size: 20
