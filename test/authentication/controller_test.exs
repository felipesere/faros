defmodule Faros.Authentication.ControllerTest do
  use Faros.ConnCase

  test "sign-in page exists" do
    conn = get conn(), "/signin"
    assert html_response(conn, 200)
  end

  test "callback" do
    conn = get conn(), "/auth/callback", %{"code" => "1", "state" => "abc"}

    assert redirected_to(conn) == "/"
  end
end
