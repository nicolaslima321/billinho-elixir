defmodule BillinhoElixirWeb.InstitutionController do
  use BillinhoElixirWeb, :controller

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Institution

  action_fallback BillinhoElixirWeb.FallbackController

  def index(conn, _params) do
    institutions = Directory.list_institutions()
    render(conn, "index.json", institutions: institutions)
  end

  def create(conn, institution_params) do
    with {:ok, true} <- params_allowed(institution_params),
         {:ok, %Institution{} = institution} <- Directory.create_institution(institution_params) do
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

  defp params_allowed(%{
    "name" => name,
    "cnpj" => cnpj,
    "kind" => kind,
  }) do
    with true <- is_binary(name),
         true <- cnpj |> String.to_integer() |> is_number(),
         true <- is_valid_kind(kind) do
      {:ok, true}
    else
      _ -> {:error, nil}
    end
  end

  defp is_valid_kind(kind) do
    if (kind == "Universidade" || kind == "Escola" || kind == "Creche") do
      true
    else
      false
    end
  end
end
