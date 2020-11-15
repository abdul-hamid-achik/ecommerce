defmodule EcommerceWeb.Router do
  use EcommerceWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {EcommerceWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :pow_layout do
    plug :put_layout, {EcommerceWeb.LayoutView, "none.html"}
    plug :put_root_layout, {EcommerceWeb.LayoutView, :none}
  end

  scope "/" do
    pipe_through [:browser, :pow_layout]

    pow_routes()
  end

  scope "/", EcommerceWeb do
    pipe_through [:browser, :protected]

    resources "/products", ProductController
  end

  scope "/", EcommerceWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", EcommerceWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: EcommerceWeb.Telemetry
    end
  end
end
