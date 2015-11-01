defmodule Faros.Authentication.ControllerTest do
  use Faros.ConnCase

  test "sign-in page exists" do
    conn = get conn(), "/signin"
    assert html_response(conn, 200)
  end

  test "fails on missing github client id" do
    System.delete_env("GITHUB_CLIENT_ID")
    System.delete_env("GITHUB_CLIENT_SECRET")
    assert_raise RuntimeError, fn ->
      get conn(), "/signin/github"
    end
  end

  test "redirects to github" do
    System.put_env("GITHUB_CLIENT_ID",     "NotTheRealDeal")
    System.put_env("GITHUB_CLIENT_SECRET", "TheSecret")
    conn = get conn(), "/signin/github"
    assert redirected_to(conn) =~ "https://github.com/login/oauth/authorize?client_id=NotTheRealDeal"
  end

  @tag :skip
  test "test has a callback url" do
    System.put_env("GITHUB_CLIENT_ID",     "NotTheRealDeal")
    System.put_env("GITHUB_CLIENT_SECRET", "TheSecret")
    conn = get conn(), "/auth/callback?code=64375c21977cec48662d&state=abc"
    assert html_response(conn, 200)
  end
end
