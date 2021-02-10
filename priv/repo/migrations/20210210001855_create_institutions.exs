defmodule BillinhoElixir.Repo.Migrations.CreateInstitutions do
  use Ecto.Migration

  def change do
    create table(:institutions) do
      add :name, :string
      add :cnpj, :text
      add :kind, :string

      timestamps()
    end

  end
end
