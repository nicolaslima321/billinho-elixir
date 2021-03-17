defmodule BillinhoElixirWeb.InvoiceController do
  use BillinhoElixirWeb, :controller

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Invoice

  action_fallback BillinhoElixirWeb.FallbackController

  def index(conn, _params) do
    invoices = Directory.list_invoices()
    render(conn, "index.json", invoices: invoices)
  end

  def show(conn, %{"id" => id}) do
    invoice = Directory.get_invoice!(id)
    render(conn, "show.json", invoice: invoice)
  end

  def update(conn, %{"id" => id, "invoice" => invoice_params}) do
    invoice = Directory.get_invoice!(id)

    with {:ok, %Invoice{} = invoice} <- Directory.update_invoice(invoice, invoice_params) do
      render(conn, "show.json", invoice: invoice)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice = Directory.get_invoice!(id)

    with {:ok, %Invoice{}} <- Directory.delete_invoice(invoice) do
      send_resp(conn, :no_content, "")
    end
  end
end
