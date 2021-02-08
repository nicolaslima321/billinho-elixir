defmodule BillinhoElixirWeb.PageController do
  use BillinhoElixirWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
