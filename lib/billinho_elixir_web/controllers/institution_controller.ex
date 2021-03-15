defmodule BillinhoElixirWeb.InstitutionController do
  use BillinhoElixirWeb, :controller

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Institution

  action_fallback BillinhoElixirWeb.FallbackController

  def index(conn, _params) do
    institutions = Directory.list_institutions()
    render(conn, "index.json", institutions: institutions)
  end

  def create(conn, %{"institution" => institution_params}) do
    with {:ok, %Institution{} = institution} <- Directory.create_institution(institution_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.institution_path(conn, :show, institution))
      |> render("show.json", institution: institution)
    end
  end

  def show(conn, %{"id" => id}) do
    institution = Directory.get_institution!(id)
    render(conn, "show.json", institution: institution)
  end

  def update(conn, %{"id" => id, "institution" => institution_params}) do
    institution = Directory.get_institution!(id)

    with {:ok, %Institution{} = institution} <- Directory.update_institution(institution, institution_params) do
      render(conn, "show.json", institution: institution)
    end
  end

  def delete(conn, %{"id" => id}) do
    institution = Directory.get_institution!(id)

    with {:ok, %Institution{}} <- Directory.delete_institution(institution) do
      send_resp(conn, :no_content, "")
    end
  end

  def wrong_params(conn, message) do
    send_resp(conn, :error, "Wrong params")
  end
end
