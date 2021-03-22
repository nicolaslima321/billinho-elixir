defmodule BillinhoElixir.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add :invoice_value, :float
      add :expiration_date, :text
      add :enrollment_id, references(:enrollments), :integer
      add :status, :text

      create index(:invoices, [:enrollment_id])
      timestamps()
    end

  end
end
