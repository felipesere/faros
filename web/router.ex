defmodule Faros.Router do
  use Faros.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/health", Faros do
    pipe_through :api

    get "/", Health.Controller, :check
  end

  scope "/", Faros do
    pipe_through :browser

    get  "/", Landing.Controller, :index

    get  "/books",            Books.Controller, :index
    get  "/books/add",        Books.Controller, :add,    as: :books
    post "/books",            Books.Controller, :create, as: :books
    get  "/books/:slug",      Books.Controller, :show,   as: :books
    get  "/books/:slug/edit", Books.Controller, :edit,   as: :books
    post "/books/:slug/edit", Books.Controller, :update, as: :books

    get  "/papers",       Papers.Controller, :index
    post "/papers",       Papers.Controller, :create, as: :papers
    get  "/papers/add",   Papers.Controller, :add,    as: :papers
    get  "/papers/:slug", Papers.Controller, :show,   as: :papers

    post "/search", Search.Controller, :index, as: :search

    get "/categories",  Categories.Controller, :index, as: :categories
    post "/categories", Categories.Controller, :add,   as: :categories
  end

  scope "/api", Faros do
    pipe_through :api

    get  "/books/lookup",     Books.Controller,   :lookup, as: :books
  end
end
