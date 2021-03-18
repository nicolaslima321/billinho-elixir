defmodule BillinhoElixirWeb.StudentController do
  use BillinhoElixirWeb, :controller

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Student

  action_fallback BillinhoElixirWeb.FallbackController

  def index(conn, _params) do
    students = Directory.list_students()
    render(conn, "index.json", students: students)
  end

  def create(conn, student_params) do
    with {:ok, true} <- params_allowed(student_params),
         {:ok, %Student{} = student} <- Directory.create_student(student_params) do

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

  defp params_allowed(params = %{
    "name" => name,
    "cpf" => cpf,
    "genre" => genre,
    "payment_method" => payment_method
  }) do
    with true <- is_binary(name),
         true <- is_binary(cpf),
         true <- is_valid_genre(genre),
         true <- is_valid_payment(payment_method) do
      {:ok, true}
    else
      _ -> {:error, nil}
    end
  end

  defp is_valid_genre(genre) do
    if (genre == "M" || genre == "F") do
      true
    else
      false
    end
  end

  defp is_valid_payment(payment_method) do
    if (payment_method == "bank_slip" || payment_method == "credit_card") do
      true
    else
      false
    end
  end
end
