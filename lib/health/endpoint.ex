defmodule Faros.Health do
  use Phoenix.Endpoint, otp_app: :faros

  plug Plug.Logger

  plug Faros.Router
end
