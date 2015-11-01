defmodule Faros.GithubTests do
  use ExUnit.Case
  alias Faros.Github

  test "the truth" do
    assert Github.parse_response(response_with_token("123")) == {:ok, "123"}
  end

  def response_with_token(token) do
    %HTTPotion.Response{
      body: "access_token=#{token}&scope=user%3Aemail&token_type=bearer",
      headers: [],
      status_code: 200}
  end
end
