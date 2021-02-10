defmodule BillinhoElixir.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :cpf, :text
      add :birth_date, :naive_datetime
      add :celphone, :integer
      add :genre, :text
      add :payment_method, :text

      timestamps()
    end

  end
end
