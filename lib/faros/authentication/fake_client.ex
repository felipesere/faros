defmodule Faros.Github.FakeApiClient do
  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def respond_with(x) do
    Agent.update(__MODULE__, fn(old) -> [ x | old] end)
  end

  def authorization_url() do
    Faros.Github.ApiClient.authorization_url()
  end

  def get_token(_code) do
    {:ok , "132"}
  end

  # token can match the token I return at the top!
  def get(token, url) do
    Agent.get_and_update(__MODULE__, fn old ->
      { List.last(old), List.delete_at(old, -1) }
    end)
  end
end
