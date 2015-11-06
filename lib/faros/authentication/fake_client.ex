defmodule Faros.Github.FakeApiClient do
  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def respond_with(x) do
    Agent.update(__MODULE__, fn(old) -> [ x | old] end)
  end

  def authorization_url() do
    Faros.Github.HttpApiClient.authorization_url()
  end

  def get_token(_code) do
    {:ok , "123"}
  end

  def get("123", _url) do
    Agent.get_and_update(__MODULE__, fn old ->
      { List.last(old), List.delete_at(old, -1) }
    end)
  end
end
