defmodule Faros.LayoutView do
  use Faros.Web, :view

  def dev() do
    Mix.env == :dev
  end
end
