defmodule BillinhoElixir.Directory.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :birth_date, :naive_datetime
    field :celphone, :integer
    field :cpf, :string
    field :genre, :string
    field :name, :string
    field :payment_method, :string

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :cpf, :birth_date, :celphone, :genre, :payment_method])
    |> validate_required([:name, :cpf, :birth_date, :celphone, :genre, :payment_method])
  end
end
