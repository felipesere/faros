defmodule Lighthouse.Books.View do
  use Lighthouse.Web, :view
  import Lighthouse.Router.Helpers

  def csrf_token(conn) do
    Phoenix.Controller.get_csrf_token
  end
end
