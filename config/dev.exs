use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :faros, Faros.Endpoint,
  http: [host: System.get_env("HOST") || "localhost",
         port: System.get_env("PORT") || "4000"],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]]

# Watch static and templates for browser reloading.
config :faros, Faros.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :faros, :book_finder, Faros.Books.GoogleFinder

config :faros, :github_api_client, Faros.Github.ApiAgent

config :faros, Faros.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "faros_dev",
  pool: Ecto.Adapters.SQL.Sandbox,
  size: 10 # The amount of database connections in the pool
