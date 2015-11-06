defmodule Faros.Github.ApiClient do
  def authorization_url() do
    Faros.Github.HttpApiClient.authorization_url()
  end

  def get_token(code) do
    api().get_token(code)
  end

  # token can match the token I return at the top!
  def get(token, url) do
    api().get(token, url)
  end

  defp api() do
    Application.get_env(:faros, :github_api_client)
  end
end
