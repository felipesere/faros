  defmodule Faros.Github.HttpApiClient do
    def authorization_url() do
      "https://github.com/login/oauth/authorize?client_id=#{client_id!()}&scope=user,read:org&state=abc"
    end

    def get_token(code) do
      response = HTTPotion.post "https://github.com/login/oauth/access_token?client_id=#{client_id!}&client_secret=#{client_secret!}&code=#{code}"
      token_response(response)
    end

    defp client_secret!() do
      System.get_env("GITHUB_CLIENT_SECRET") || raise "Missing Github secret"
    end

    defp client_id!() do
      System.get_env("GITHUB_CLIENT_ID") || raise "Missing Github client id"
    end

    def token_response(%HTTPotion.Response{body: body, status_code: 200}) do
      body |> parse_body
    end

    def token_response(%HTTPotion.Response{body: body, status_code: 401}) do
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

    def get(token, url) do
      token
      |> _get(url)
      |> parse
    end

    defp _get(token, url) do
      HTTPotion.get url, [headers: ["Authorization": "token #{token}", "User-Agent": "Mozilla"], timeout: 10000]
    end

    def parse(%HTTPotion.Response{body: body, status_code: 200}) do
      Poison.decode(body)
    end

    def parse(%HTTPotion.Response{body: body, status_code: code}) do
      {:error, [body: body, status: code]}
    end
  end
