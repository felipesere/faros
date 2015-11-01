defmodule Faros.Authentication.ControllerTest do
  use Faros.ConnCase

  test "sign-in page exists" do
    conn = get conn(), "/signin"
    assert html_response(conn, 200)
  end

  test "fails on missing github client id" do
    System.delete_env("GITHUB_CLIENT_ID")
    assert_raise RuntimeError, fn ->  
      get conn(), "/signin/github" 
    end
  end

  test "redirects to github" do
    System.put_env("GITHUB_CLIENT_ID", "NotTheRealDeal")
    conn = get conn(), "/signin/github"
    assert redirected_to(conn) =~ "https://github.com/login/oauth/authorize?client_id=NotTheRealDeal" 
  end
end
