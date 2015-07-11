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

    get  "/",                 Landing.Controller, :index
    get  "/books",            Books.Controller,   :index
    get  "/books/add",        Books.Controller,   :add,    as: :books
    post "/books/add",        Books.Controller,   :create, as: :books
    get  "/books/:slug",      Books.Controller,   :show,   as: :books
    post "/books/:slug/edit", Books.Controller,   :edit,   as: :books
    get  "/books/:slug/edit", Books.Controller,   :form
  end
end
