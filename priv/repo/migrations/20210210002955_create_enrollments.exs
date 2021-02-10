defmodule BillinhoElixir.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :total_price, :float
      add :invoice_quantity, :integer
      add :course_name, :text
      add :institution_id, :integer
      add :student_id, :integer

      timestamps()
    end

  end
end
