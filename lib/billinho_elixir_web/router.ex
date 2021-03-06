defmodule BillinhoElixirWeb.Router do
  use BillinhoElixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BillinhoElixirWeb do
    pipe_through :api

    get "/", PageController, :index

    get "/enrolments", EnrollmentController, :index
    get "/enrolments/:id", EnrollmentController, :show
    post "/enrolments", EnrollmentController, :create

    get "/invoices", InvoiceController, :index
    get "/invoices/:id", InvoiceController, :show

    get "/students", StudentController, :index
    get "/students/:id", StudentController, :show
    post "/students", StudentController, :create

    get "/institutions", InstitutionController, :index
    get "/institutions/:id", InstitutionController, :show
    post "/institutions", InstitutionController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", BillinhoElixirWeb do
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
      live_dashboard "/dashboard", metrics: BillinhoElixirWeb.Telemetry
    end
  end
end
