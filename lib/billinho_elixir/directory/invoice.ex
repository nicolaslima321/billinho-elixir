defmodule BillinhoElixir.Directory.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoices" do
    field :enrollment_id, :integer
    field :expiration_date, :string
    field :invoice_value, :float
    field :status, :string
    belongs_to :enrollments, BillinhoElixir.Directory.Enrollment

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:invoice_value, :expiration_date, :enrollment_id, :status])
    |> validate_required([:invoice_value, :expiration_date, :enrollment_id, :status])
  end
end
