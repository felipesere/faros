defmodule Faros.GithubTests do
  use ExUnit.Case
  alias Faros.Github
  alias Faros.Github.FakeApiClient
  alias Faros.User

  setup_all do
    old_val = Application.get_env(:faros, :github_api_client)
    Application.put_env(:faros, :github_api_client, Faros.Github.FakeApiClient)

    on_exit fn ->
      Application.put_env(:faros, :github_api_client, old_val)
    end
    :ok
  end

  test "gets a user" do
    FakeApiClient.start
    FakeApiClient.respond_with({:ok, user_response})
    FakeApiClient.respond_with({:ok, organization_response})
    FakeApiClient.respond_with({:ok, email_response})
    {:ok, user} =  Github.get_user("123")
    assert user.name == "Felipe Seré"
    assert user.organization == "8thlight"
    assert user.email == "felipesere@gmail.com"
  end

  test "fails to find a user" do
    FakeApiClient.start
    FakeApiClient.respond_with({:error, "..."})
    FakeApiClient.respond_with({:ok, organization_response})
    FakeApiClient.respond_with({:ok, email_response})
    response =  Github.get_user("123")
    assert response == {:error, :could_not_find_user}
  end

  test "fails to find an organisation" do
    FakeApiClient.start
    FakeApiClient.respond_with({:ok, user_response})
    FakeApiClient.respond_with({:error, "..."})
    FakeApiClient.respond_with({:ok, email_response})
    response =  Github.get_user("123")
    assert response == {:error, :could_not_find_organization}
  end

  test "fails to find an email" do
    FakeApiClient.start
    FakeApiClient.respond_with({:ok, user_response})
    FakeApiClient.respond_with({:ok, organization_response})
    FakeApiClient.respond_with({:error, "..."})
    response =  Github.get_user("123")
    assert response == {:error, :could_not_find_email}
  end

  test "parses the basic user info" do
    {:ok, user} = user_response |> Github.parse_user(%User{})
    assert user.name == "Felipe Seré"
  end

  test "parses the organizations" do
    {:ok, user} = organization_response |> Github.parse_organizations(%User{})
    assert user.organization == "8thlight"
  end

  test "parses the emails" do
    {:ok, user} = email_response |> Github.parse_emails(%User{})
    assert user.email == "felipesere@gmail.com"
  end

  def user_response do
    %{ "name" => "Felipe Seré" }
  end

  def organization_response do
    [ %{ "login" => "8thlight" }, %{ "login" => "something" }]
  end

  def email_response do
    [ %{"email" => "felipesere@gmail.com","primary" => true, "verified" => true},
      %{"email" => "felipe@8thlight.com", "primary" => false,"verified" => true}]
  end
end
