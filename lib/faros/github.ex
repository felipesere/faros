defmodule Faros.Github do
  def get_token(code) do
    HTTPotion.post "https://github.com/login/oauth/access_token?client_id=#{client_id!}&client_secret=#{client_secret!}&code=#{code}"
    |> parse_response
  end

  def parse_response(%HTTPotion.Response{body: body, status_code: 200}) do
    body |> parse_body
  end

  def parse_response(%HTTPotion.Response{body: body, status_code: 401}) do
    {:error, "Not authenticated: #{body}"}
  end

  defp parse_body(body) do
    case extract_token(body)  do
      [first | _] -> {:ok, first }
      _ -> {:error, "Could not extract token from body: #{body}"}
    end
  end

  defp extract_token(body) do
    Regex.run(~r/access_token=([^&]+)/, body, [capture: :all_but_first])
  end

  def authorization_url() do
    "https://github.com/login/oauth/authorize?client_id=#{client_id!()}&scope=user:email&state=abc"
  end

  defp client_secret!() do
    System.get_env("GITHUB_CLIENT_SECRET") || raise "Missing Github secret"
  end

  defp client_id!() do
    System.get_env("GITHUB_CLIENT_ID") || raise "Missing Github client id"
  end
end
