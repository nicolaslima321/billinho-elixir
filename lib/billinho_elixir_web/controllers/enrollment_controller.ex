defmodule BillinhoElixirWeb.EnrollmentController do
  use BillinhoElixirWeb, :controller

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Enrollment

  action_fallback BillinhoElixirWeb.FallbackController

  def index(conn, _params) do
    enrollments = Directory.list_enrollments()
    render(conn, "index.json", enrollments: enrollments)
  end

  def create(conn, %{"enrollment" => enrollment_params}) do
    with {:ok, %Enrollment{} = enrollment} <- Directory.create_enrollment(enrollment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.enrollment_path(conn, :show, enrollment))
      |> render("show.json", enrollment: enrollment)
    end
  end

  def show(conn, %{"id" => id}) do
    enrollment = Directory.get_enrollment!(id)
    render(conn, "show.json", enrollment: enrollment)
  end

  def update(conn, %{"id" => id, "enrollment" => enrollment_params}) do
    enrollment = Directory.get_enrollment!(id)

    with {:ok, %Enrollment{} = enrollment} <- Directory.update_enrollment(enrollment, enrollment_params) do
      render(conn, "show.json", enrollment: enrollment)
    end
  end

  def delete(conn, %{"id" => id}) do
    enrollment = Directory.get_enrollment!(id)

    with {:ok, %Enrollment{}} <- Directory.delete_enrollment(enrollment) do
      send_resp(conn, :no_content, "")
    end
  end

  def wrong_params(conn) do
    send_resp(conn, :error, "Wrong params")
  end
end
