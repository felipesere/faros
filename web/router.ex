defmodule Faros.Router do
  use Faros.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Faros do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/styleguide", PageController, :styleguide
    get "/path-step", PageController, :path_step
    get "/path-overview", PageController, :path_overview
  end
end
