defmodule Lighthouse.Landing.ControllerTest do
  use Lighthouse.ConnCase

  test "returns 200" do
    conn = get conn(), "/"
    assert html_response(conn, 200) 
  end
end
