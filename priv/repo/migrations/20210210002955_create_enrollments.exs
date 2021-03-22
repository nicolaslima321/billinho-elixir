defmodule BillinhoElixir.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :total_price, :float
      add :invoice_quantity, :integer
      add :course_name, :text
      add :institution_id, references(:institutions)
      add :student_id, references(:students)

      timestamps()
    end

    create index(:enrollments, [:institution_id, :student_id])
  end
end
