defmodule Faros.Github.DummyGithub do
  alias Faros.User

  def get_user(_code) do
    %User{name: "Joe Blogs", organization: "8thlight", email: "joe@blogs.com"}
  end

  def authorization_url() do
    "/auth/callback?code=123&state=abc"
  end
end
