defmodule BillinhoElixirWeb.InvoiceView do
  use BillinhoElixirWeb, :view
  alias BillinhoElixirWeb.InvoiceView

  def render("index.json", %{invoices: invoices}) do
    %{data: render_many(invoices, InvoiceView, "invoice.json")}
  end

  def render("show.json", %{invoice: invoice}) do
    %{data: render_one(invoice, InvoiceView, "invoice.json")}
  end

  def render("invoice.json", %{invoice: invoice}) do
    %{id: invoice.id,
      invoice_value: invoice.invoice_value,
      expiration_date: invoice.expiration_date,
      enrollment_id: invoice.enrollment_id,
      status: invoice.status}
  end
end
