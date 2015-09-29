defmodule Faros.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      import Faros.Router.Helpers
      @endpoint Faros.Endpoint
    end
  end
end
