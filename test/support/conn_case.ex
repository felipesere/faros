defmodule Lighthouse.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      import Lighthouse.Router.Helpers
      @endpoint Lighthouse.Endpoint
    end
  end
end
