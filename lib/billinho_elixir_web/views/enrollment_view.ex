defmodule BillinhoElixirWeb.EnrollmentView do
  use BillinhoElixirWeb, :view
  alias BillinhoElixirWeb.EnrollmentView

  def render("index.json", %{enrollments: enrollments}) do
    %{data: render_many(enrollments, EnrollmentView, "enrollment.json")}
  end

  def render("show.json", %{enrollment: enrollment}) do
    %{data: render_one(enrollment, EnrollmentView, "enrollment.json")}
  end

  def render("enrollment.json", %{enrollment: enrollment}) do
    %{id: enrollment.id,
      total_price: enrollment.total_price,
      invoice_quantity: enrollment.invoice_quantity,
      course_name: enrollment.course_name,
      institution_id: enrollment.institution_id,
      student_id: enrollment.student_id}
  end
end
