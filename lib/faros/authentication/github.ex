defmodule Faros.Github do
  alias Faros.User
  alias Faros.Github.ApiClient


  def get_user(token) do
    %User{}
    |> attach_basics(token)
    |> attach_organization(token)
    |> attach_email(token)
  end

  def attach_basics(user, token) do
    token
    |> ApiClient.get("https://api.github.com/user")
    |> parse_user(user)
  end

  def attach_organization(user, token) do
    token
    |> ApiClient.get("https://api.github.com/user/orgs")
    |> parse_organizations(user)
  end

  def attach_email(user, token) do
    token
    |> ApiClient.get("https://api.github.com/user/emails")
    |> parse_emails(user)
  end

  def update_organizations(organisations, user) do
    %User{ user | organization: List.first(organisations) }
  end

  def parse_emails({:ok, emails}, user) do
    emails
    |> Enum.find( fn(email) -> email["primary"] end)
    |> update_email(user)
  end

  def update_email(%{"email" => email}, user) do
    %User{ user | email: email}
  end

  def parse_organizations({:ok, organizations}, user) do
    organizations
    |> Enum.map(fn(attributes) -> attributes["login"] end)
    |> update_organizations(user)
  end

  def parse_user({:ok, user_attributes}, user) do
    %User{ user | name: user_attributes["name"] }
  end

  def get_token(code) do
    ApiClient.get_token(code)
  end

  def authorization_url() do
    ApiClient.authorization_url()
  end
end
