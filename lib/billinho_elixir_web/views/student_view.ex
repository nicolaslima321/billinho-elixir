defmodule BillinhoElixirWeb.StudentView do
  use BillinhoElixirWeb, :view
  alias BillinhoElixirWeb.StudentView

  def render("index.json", %{students: students}) do
    %{data: render_many(students, StudentView, "student.json")}
  end

  def render("show.json", %{student: student}) do
    %{data: render_one(student, StudentView, "student.json")}
  end

  def render("student.json", %{student: student}) do
    %{id: student.id,
      name: student.name,
      cpf: student.cpf,
      birth_date: student.birth_date,
      celphone: student.celphone,
      genre: student.genre,
      payment_method: student.payment_method}
  end
end
