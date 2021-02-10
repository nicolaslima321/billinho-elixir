defmodule BillinhoElixirWeb.InvoiceControllerTest do
  use BillinhoElixirWeb.ConnCase

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Invoice

  @create_attrs %{
    enrollment_id: 42,
    expiration_date: ~N[2010-04-17 14:00:00],
    invoice_value: 120.5,
    status: "some status"
  }
  @update_attrs %{
    enrollment_id: 43,
    expiration_date: ~N[2011-05-18 15:01:01],
    invoice_value: 456.7,
    status: "some updated status"
  }
  @invalid_attrs %{enrollment_id: nil, expiration_date: nil, invoice_value: nil, status: nil}

  def fixture(:invoice) do
    {:ok, invoice} = Directory.create_invoice(@create_attrs)
    invoice
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all invoices", %{conn: conn} do
      conn = get(conn, Routes.invoice_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create invoice" do
    test "renders invoice when data is valid", %{conn: conn} do
      conn = post(conn, Routes.invoice_path(conn, :create), invoice: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.invoice_path(conn, :show, id))

      assert %{
               "id" => id,
               "enrollment_id" => 42,
               "expiration_date" => "2010-04-17T14:00:00",
               "invoice_value" => 120.5,
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.invoice_path(conn, :create), invoice: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update invoice" do
    setup [:create_invoice]

    test "renders invoice when data is valid", %{conn: conn, invoice: %Invoice{id: id} = invoice} do
      conn = put(conn, Routes.invoice_path(conn, :update, invoice), invoice: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.invoice_path(conn, :show, id))

      assert %{
               "id" => id,
               "enrollment_id" => 43,
               "expiration_date" => "2011-05-18T15:01:01",
               "invoice_value" => 456.7,
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, invoice: invoice} do
      conn = put(conn, Routes.invoice_path(conn, :update, invoice), invoice: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete invoice" do
    setup [:create_invoice]

    test "deletes chosen invoice", %{conn: conn, invoice: invoice} do
      conn = delete(conn, Routes.invoice_path(conn, :delete, invoice))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.invoice_path(conn, :show, invoice))
      end
    end
  end

  defp create_invoice(_) do
    invoice = fixture(:invoice)
    %{invoice: invoice}
  end
end
