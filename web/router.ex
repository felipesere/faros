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
    pipe_through :browser

    get "/books", Books.Controller, :index
    get "/books/:isbn", Books.Controller, :show, as: :books
  end
end
