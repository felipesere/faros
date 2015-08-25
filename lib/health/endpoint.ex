defmodule Lighthouse.Health do
  use Phoenix.Endpoint, otp_app: :lighthouse

  plug Plug.Logger

  plug Lighthouse.Router
end
