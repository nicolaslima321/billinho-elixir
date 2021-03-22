defmodule BillinhoElixir.Directory.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "enrollments" do
    field :course_name, :string
    field :institution_id, :integer
    field :invoice_quantity, :integer
    field :student_id, :integer
    field :total_price, :float
    has_many :invoices, BillinhoElixir.Directory.Invoice
    has_many :students, BillinhoElixir.Directory.Student
  
    timestamps()
  end

  @doc false
  def changeset(enrollment, attrs) do
    enrollment
    |> cast(attrs, [:total_price, :invoice_quantity, :course_name, :institution_id, :student_id])
    |> validate_required([:total_price, :invoice_quantity, :course_name, :institution_id, :student_id])
  end
end
