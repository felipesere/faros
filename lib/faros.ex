defmodule Faros do
  use Application
  alias Ecto.Migrator
  alias Ecto.Storage
  alias Faros.Github.ApiAgent

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Faros.Endpoint, []),
      supervisor(Faros.Health, []),

      # Start the Ecto repository
      worker(Faros.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(Faros.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Faros.Supervisor]
    result = Supervisor.start_link(children, opts)

    if Application.get_env(:faros, :github_api_client) == Faros.Github.ApiAgent do
      ApiAgent.start(client_id!, client_secret!)
    end

    update_database(Faros.Repo)

    result
  end


  defp client_secret!() do
    System.get_env("GITHUB_CLIENT_SECRET") || raise "Missing Github secret"
  end

  defp client_id!() do
    System.get_env("GITHUB_CLIENT_ID") || raise "Missing Github client id"
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Faros.Endpoint.config_change(changed, removed)
    :ok
  end

  defp update_database(repo) do
    create_db(repo)
    migrate(repo)
  end

  def create_db(repo) do
    create_db(repo, 0, 10, nil)
  end

  def create_db(repo, attempts, max_attempts, term) when attempts >= max_attempts do
    raise "Could not create database #{inspect repo} after #{attempts} attempts: #{term}"
  end

  def create_db(repo, attempts, max_attempts, _term) do
    case Storage.up(repo) do
      :ok ->
        IO.puts "The database for #{inspect repo} has been created."
      {:error, :already_up} ->
        IO.puts "The database for #{inspect repo} has already been created."
      {:error, term} -> :timer.sleep(5000); create_db(repo, attempts+1, max_attempts, term)
    end
  end


  def migrate(repo) do
    path = get_path
    Migrator.run(repo, path, :up, [all: True, log: :info])
  end

  defp get_path do
    case System.get_env("MIGRATION_PATH") do
     nil  -> "priv/repo/migrations"
     path -> path
    end
  end
end
