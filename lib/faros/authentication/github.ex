defmodule Faros.Github do
  alias Faros.User
  alias Faros.Github.ApiClient

  def get_user(code) when is_binary(code) do
    code
    |> ApiClient.get_token
    |> get_user
  end

  def get_user({:ok, token}) do
    {:ok, %User{}}
    |> attach_basics(token)
    |> attach_organization(token)
    |> attach_email(token)
  end

  def attach_basics({:ok, user}, token) do
    case ApiClient.get(token, "https://api.github.com/user") do
      {:error, _} -> {:error, :could_not_find_user}
      {:ok, user_attributes} -> parse_user(user_attributes, user)
    end
  end

  def parse_user(user_attributes, user) do
    {:ok, %User{ user | name: user_attributes["name"] }}
  end


  def attach_organization({:ok, user}, token) do
    case ApiClient.get(token, "https://api.github.com/user/orgs") do
      {:error, _} -> {:error, :could_not_find_organization}
      {:ok, organizations} -> parse_organizations(organizations, user)
    end
  end
  def attach_organization(error, _token), do: error

  def parse_organizations(organizations, user) do
    organizations
    |> Enum.map(fn(attributes) -> attributes["login"] end)
    |> update_organizations(user)
  end

  def update_organizations([organization | _ ], user) do
    {:ok, %User{ user | organization: organization }}
  end

  def attach_email({:ok, user}, token) do
    case ApiClient.get(token, "https://api.github.com/user/emails") do
      {:error, _} -> {:error, :could_not_find_email}
      {:ok, emails} -> parse_emails(emails, user)
    end
  end
  def attach_email(error, _token), do: error

  def parse_emails(emails, user) do
    emails
    |> Enum.find( fn(email) -> email["primary"] end)
    |> update_email(user)
  end

  def update_email(%{"email" => email}, user) do
    {:ok, %User{ user | email: email}}
  end

  def authorization_url() do
    ApiClient.authorization_url()
  end
end
