defmodule Lighthouse.BooksControllerTest do
  use Lighthouse.ConnCase

  test "returns 200" do
    %{status: status} = get conn(), "/books"
    assert status == 200
  end
end
