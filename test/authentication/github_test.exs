defmodule Faros.GithubTests do
  use ExUnit.Case
  alias Faros.Github
  alias Faros.User

  test "extracts a token out of a response" do
    result = token_response("123") |> Github.parse_response
    assert result == {:ok, "123"}
  end

  test "errors when not authenticated" do
    result = unauthenticated |> Github.parse_response
    assert result == {:error, "Not authenticated: something I don't know"}
  end

  test "parses the basic user info" do
    user = user_response |> Github.parse_user_response(%User{})
    assert user.name == "Felipe Seré"
  end

  test "parses the organizations" do
    user = organization_response |> Github.parse_organizations_response(%User{})
    assert user.organization == "8thlight"
  end

  test "parses the emails" do
    user = email_response |> Github.parse_emails_response(%User{})
    assert user.email == "felipesere@gmail.com"
  end

  def unauthenticated do
    %HTTPotion.Response{
      body: "something I don't know",
      headers: [],
      status_code: 401}
  end

  def token_response(token) do
    %HTTPotion.Response{
      body: "access_token=#{token}&scope=user%3Aemail&token_type=bearer",
      headers: [],
      status_code: 200}
  end

  def user_response do
    %HTTPotion.Response{
      body: "{\"login\":\"felipesere\",\"id\":1850188,\"avatar_url\":\"https://avatars.githubusercontent.com/u/1850188?v=3\",\"gravatar_id\":\"\",\"url\":\"https://api.github.com/users/felipesere\",\"html_url\":\"https://github.com/felipesere\",\"followers_url\":\"https://api.github.com/users/felipesere/followers\",\"following_url\":\"https://api.github.com/users/felipesere/following{/other_user}\",\"gists_url\":\"https://api.github.com/users/felipesere/gists{/gist_id}\",\"starred_url\":\"https://api.github.com/users/felipesere/starred{/owner}{/repo}\",\"subscriptions_url\":\"https://api.github.com/users/felipesere/subscriptions\",\"organizations_url\":\"https://api.github.com/users/felipesere/orgs\",\"repos_url\":\"https://api.github.com/users/felipesere/repos\",\"events_url\":\"https://api.github.com/users/felipesere/events{/privacy}\",\"received_events_url\":\"https://api.github.com/users/felipesere/received_events\",\"type\":\"User\",\"site_admin\":false,\"name\":\"Felipe Seré\",\"company\":\"8th Light\",\"blog\":null,\"location\":\"London\",\"email\":null,\"hireable\":null,\"bio\":null,\"public_repos\":34,\"public_gists\":7,\"followers\":12,\"following\":8,\"created_at\":\"2012-06-14T12:42:08Z\",\"updated_at\":\"2015-10-25T14:23:32Z\"}",
      headers: [],
      status_code: 200}
  end

  def organization_response do
%HTTPotion.Response{body: "[{\"login\":\"8thlight\",\"id\":62,\"url\":\"https://api.github.com/orgs/8thlight\",\"repos_url\":\"https://api.github.com/orgs/8thlight/repos\",\"events_url\":\"https://api.github.com/orgs/8thlight/events\",\"members_url\":\"https://api.github.com/orgs/8thlight/members{/member}\",\"public_members_url\":\"https://api.github.com/orgs/8thlight/public_members{/member}\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/691v=3\",\"description\":\"Software is our Craft\"},{\"login\":\"something\",\"id\":3511,\"url\":\"https://api.github.com/orgs/something\",\"repos_url\":\"https://api.github.com/orgs/something/repos\",\"events_url\":\"https://api.github.com/orgs/something/events\",\"members_url\":\"https://api.github.com/orgs/something/members{/member}\",\"public_members_url\":\"https://api.github.com/orgs/something/public_members{/member}\",\"avatar_url\":\"https://avatars.githubusercontent.com/u/3001?v=3\",\"description\":\"\"}]",
  headers: [],
  status_code: 200}
  end

  def email_response do
%HTTPotion.Response{body: "[{\"email\":\"felipesere@gmail.com\",\"primary\":true,\"verified\":true},{\"email\":\"felipe@8thlight.com\",\"primary\":false,\"verified\":true}]",
  headers: [],
  status_code: 200}
  end
end
