defmodule BillinhoElixir.Directory.Institution do
  use Ecto.Schema
  import Ecto.Changeset

  schema "institutions" do
    field :cnpj, :string
    field :kind, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(institution, attrs) do
    institution
    |> cast(attrs, [:name, :cnpj, :kind])
    |> validate_required([:name, :cnpj, :kind])
  end
end
