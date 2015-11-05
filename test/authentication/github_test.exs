defmodule Faros.GithubTests do
  use ExUnit.Case
  alias Faros.Github
  alias Faros.User

  test "parses the basic user info" do
    user = {:ok, user_response} |> Github.parse_user(%User{})
    assert user.name == "Felipe Seré"
  end

  test "parses the organizations" do
    user = {:ok, organization_response} |> Github.parse_organizations(%User{})
    assert user.organization == "8thlight"
  end

  test "parses the emails" do
    user = {:ok, email_response} |> Github.parse_emails(%User{})
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
