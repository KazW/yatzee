defmodule YatzeeWeb.Router do
  use YatzeeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {YatzeeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :set_color_scheme
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", YatzeeWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/splash", PageController, :splash
    live "/live", PageLive, :index
    live "/live/modal/:size", PageLive, :modal
    live "/live/slide_over/:origin", PageLive, :slide_over
    live "/live/pagination/:page", PageLive, :pagination
  end

  # Other scopes may use custom stacks.
  # scope "/api", YatzeeWeb do
  #   pipe_through :api
  # end

  # PWA related endpoints
  scope "/pwa", YatzeeWeb do
    pipe_through :api

    get "/manifest", PwaController, :manifest
  end

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

      live_dashboard "/dashboard", metrics: YatzeeWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  # Use this plug to set a "dark" css class on <html> element
  defp set_color_scheme(conn, _opts) do
    color_scheme = conn.cookies["color-scheme"] || "dark"

    conn
    |> assign(:color_scheme, color_scheme)
    |> put_session(:color_scheme, color_scheme)
  end
end
