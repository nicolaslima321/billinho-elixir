defmodule BillinhoElixirWeb.InstitutionControllerTest do
  use BillinhoElixirWeb.ConnCase

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Institution

  @create_attrs %{
    cnpj: "some cnpj",
    kind: "some kind",
    name: "some name"
  }
  @update_attrs %{
    cnpj: "some updated cnpj",
    kind: "some updated kind",
    name: "some updated name"
  }
  @invalid_attrs %{cnpj: nil, kind: nil, name: nil}

  def fixture(:institution) do
    {:ok, institution} = Directory.create_institution(@create_attrs)
    institution
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all institutions", %{conn: conn} do
      conn = get(conn, Routes.institution_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create institution" do
    test "renders institution when data is valid", %{conn: conn} do
      conn = post(conn, Routes.institution_path(conn, :create), institution: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.institution_path(conn, :show, id))

      assert %{
               "id" => id,
               "cnpj" => "some cnpj",
               "kind" => "some kind",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.institution_path(conn, :create), institution: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update institution" do
    setup [:create_institution]

    test "renders institution when data is valid", %{conn: conn, institution: %Institution{id: id} = institution} do
      conn = put(conn, Routes.institution_path(conn, :update, institution), institution: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.institution_path(conn, :show, id))

      assert %{
               "id" => id,
               "cnpj" => "some updated cnpj",
               "kind" => "some updated kind",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, institution: institution} do
      conn = put(conn, Routes.institution_path(conn, :update, institution), institution: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete institution" do
    setup [:create_institution]

    test "deletes chosen institution", %{conn: conn, institution: institution} do
      conn = delete(conn, Routes.institution_path(conn, :delete, institution))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.institution_path(conn, :show, institution))
      end
    end
  end

  defp create_institution(_) do
    institution = fixture(:institution)
    %{institution: institution}
  end
end
