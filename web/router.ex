defmodule JrnyPlnr.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", JrnyPlnr do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/", PageController, :login

    get "/signin", PageController, :signin
    post "/signin", PageController, :signup

    get "/home", PageController, :home
    
    get "/plan", PageController, :plan

    get "/sch", PageController, :sch
    
    get "/map", PageController, :map
    post "/map", PageController, :ins_sch

    get "/calendar", PageController, :calendar

    get "/pears", PageController, :pears

    get "/comm", PageController, :comm
   
    get "/profile", PageController, :profile

    post "/sch/upd", PageController, :upd_sch
    post "/sch/del", PageController, :del_sch
  end

  # Other scopes may use custom stacks.
  # scope "/api", JrnyPlnr do
  #   pipe_through :api
  # end
end
