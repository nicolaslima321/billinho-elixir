defmodule BillinhoElixirWeb.StudentController do
  use BillinhoElixirWeb, :controller

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Student

  action_fallback BillinhoElixirWeb.FallbackController

  def index(conn, _params) do
    students = Directory.list_students()
    render(conn, "index.json", students: students)
  end

  def create(conn, %{"student" => student_params}) do
    with {:ok, %Student{} = student} <- Directory.create_student(student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.student_path(conn, :show, student))
      |> render("show.json", student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Directory.get_student!(id)
    render(conn, "show.json", student: student)
  end
end
