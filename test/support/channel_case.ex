defmodule Lighthouse.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ChannelTest
      @endpoint Lighthouse.Endpoint
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Lighthouse.Repo, [])
    end

    :ok
  end
end
