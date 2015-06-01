defmodule Lighthouse.Router do
  use Lighthouse.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Lighthouse do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/books", BooksController, :index
  end
  # Other scopes may use custom stacks.
  # scope "/api", Lighthouse do
  #   pipe_through :api
  # end
end
