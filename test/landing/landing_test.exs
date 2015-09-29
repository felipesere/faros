defmodule Faros.Landing.ControllerTest do
  use Faros.ConnCase

  test "returns 200" do
    conn = get conn(), "/"
    assert html_response(conn, 200) 
  end
end
