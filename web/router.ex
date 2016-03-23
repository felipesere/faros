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
    get "/path-overview", PageController, :path_overview
    get "/path-step-1", PageController, :path_step_1
    get "/path-step-4", PageController, :path_step_4
    get "/path-step-6", PageController, :path_step_6
    get "/progress", PageController, :progress
  end
end
