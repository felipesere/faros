defmodule Faros.Github.ApiAgent do
  def start(client_id, client_secret) do
    IO.puts "Starting the agent"
    Agent.start_link(fn -> [client_id, client_secret] end, 
                     name: __MODULE__)
  end

  def authorization_url do
    client_id! |> Faros.Github.HttpApiClient.authorization_url
  end

  def get_token(code) do
    IO.puts "Using the agent to get a token"
    Faros.Github.HttpApiClient.get_token(code, client_id!, client_secret!)
  end

  def get(url, token), do: Faros.Github.HttpApiClient.get(url, token)

  defp client_id! do
    Agent.get(__MODULE__, fn([client_id, _])  -> client_id end)
  end

  defp client_secret! do
    Agent.get(__MODULE__, fn([_, client_secret])  -> client_secret end)
  end
end


defmodule Faros.Github.HttpApiClient do
  def authorization_url(client_id) do
    "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=user,read:org&state=abc"
  end

  def get_token(code, client_id, client_secret) do
    response = HTTPotion.post "https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}"
    token_response(response)
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
