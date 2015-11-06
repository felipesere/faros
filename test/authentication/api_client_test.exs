defmodule Faros.ApiClientTests do
  use ExUnit.Case
  alias Faros.Github.HttpApiClient

  test "extracts a token out of a response" do
    result = token_response("123") |> HttpApiClient.token_response
    assert result == {:ok, "123"}
  end

  test "errors when not authenticated" do
    result = unauthenticated |> HttpApiClient.token_response
    assert result == {:error, "Not authenticated: something I don't know"}
  end

  def unauthenticated do
    %HTTPotion.Response{
      body: "something I don't know",
      headers: [],
      status_code: 401}
  end

  def token_response(token) do
    %HTTPotion.Response{body: "access_token=#{token}&scope=user%3Aemail&token_type=bearer", headers: [], status_code: 200}
  end
end
