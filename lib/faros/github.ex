defmodule Faros.Github do
  defmodule User do
    defstruct name: nil, organization: nil, email: nil, token: nil
  end

  def get_user(token) do
    %User{}
    |> attach_basics(token)
    |> attach_organization(token)
    |> attach_email(token)
  end

  def attach_basics(user, token) do
    token
    |> get("https://api.github.com/user")
    |> parse_user_response(user)
  end

  def attach_organization(user, token) do
    token
    |> get("https://api.github.com/user/orgs")
    |> parse_organizations_response(user)
  end

  def attach_email(user, token) do
    token
    |> get("https://api.github.com/user/emails")
    |> parse_emails_response(user)
  end

  def update_organizations(organisations, user) do
    %User{ user | organization: List.first(organisations) }
  end

  def parse_emails_response(%HTTPotion.Response{body: body, status_code: 200}, user) do
    body
    |> Poison.decode
    |> parse_emails_response(user)
  end

  def parse_emails_response({:ok, emails}, user) do
    emails
    |> Enum.find( fn(email) -> email["primary"] end)
    |> update_email(user)
  end

  def update_email(%{"email" => email}, user) do
    %User{ user | email: email}
  end

  def parse_organizations_response(%HTTPotion.Response{body: body, status_code: 200}, user) do
    body
    |> Poison.decode
    |> parse_organizations_response(user)
  end

  def parse_organizations_response({:ok, organizations}, user) do
    organizations
    |> Enum.map(fn(attributes) -> attributes["login"] end)
    |> update_organizations(user)
  end

  def parse_user_response(%HTTPotion.Response{body: body, status_code: 200}, user) do
    body
    |> Poison.decode
    |> parse_user_response(user)
  end

  def parse_user_response({:ok, user_attributes}, user) do
    %User{ user | name: user_attributes["name"] }
  end

  def get_token(code) do
    response = HTTPotion.post "https://github.com/login/oauth/access_token?client_id=#{client_id!}&client_secret=#{client_secret!}&code=#{code}"
    parse_response(response)
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
    "https://github.com/login/oauth/authorize?client_id=#{client_id!()}&scope=user,read:org&state=abc"
  end

  defp client_secret!() do
    System.get_env("GITHUB_CLIENT_SECRET") || raise "Missing Github secret"
  end

  defp client_id!() do
    System.get_env("GITHUB_CLIENT_ID") || raise "Missing Github client id"
  end

  def get(token, url) do
    HTTPotion.get url, [headers: ["Authorization": "token #{token}", "User-Agent": "Mozilla"], timeout: 10000]
  end
end
