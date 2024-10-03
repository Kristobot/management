defmodule ManagementWeb.Router do
  use ManagementWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ManagementWeb.Authentication
  end

  scope "/api", ManagementWeb do
    pipe_through :api
    post "/users", UserController, :create
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users/login", SessionController, :authenticate
  end

  scope "/api", ManagementWeb do
    pipe_through [:api, :auth]

    get "/profile", UserController, :profile
    post "/profile", PersonController, :create
  end


  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:management, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ManagementWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
