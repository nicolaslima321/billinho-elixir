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
end
