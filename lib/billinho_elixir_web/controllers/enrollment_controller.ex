defmodule BillinhoElixirWeb.EnrollmentController do
  require Logger

  use BillinhoElixirWeb, :controller

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Enrollment
  alias BillinhoElixir.Directory.Invoice

  action_fallback BillinhoElixirWeb.FallbackController

  def index(conn, _params) do
    enrollments = Directory.list_enrollments()
    render(conn, "index.json", enrollments: enrollments)
  end

  def create(conn, enrollment_params) do
    with {:ok, true} <- params_allowed(enrollment_params),
         {:ok, %Enrollment{} = enrollment} <- Directory.create_enrollment(enrollment_params),
         {:ok, invoices} <- create_invoices(enrollment, enrollment_params) do

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.enrollment_path(conn, :show, enrollment))
      |> render("show.json", %{
        enrollment: enrollment,
        invoices: invoices,
      })
    end
  end

  def show(conn, %{"id" => id}) do
    enrollment = Directory.get_enrollment!(id)
    render(conn, "show.json", enrollment: enrollment)
  end

  defp create_invoices(enrolment, %{"expiration_day" => expiration_day}) do
    current_month = Timex.now().month
    invoice_quantity = enrolment.invoice_quantity
    invoices = %{}

    Enum.each(1..invoice_quantity, fn(n) ->
      Logger.info("Creating #{IO.inspect(n)}º invoice")
      current_invoice = calculate_invoice(enrolment, current_month, expiration_day)
      {:ok, %Invoice{} = invoice} = Directory.create_invoice(current_invoice)

      # Logger.info("Debug #{IO.inspect(current_invoice)}")
      
      Map.put_new(invoices, n, invoice)
      current_month =+ 1
  
      if (current_month >= 12) do
        current_month = 1
      end
    end)

    {:ok, invoices}
  end

  defp calculate_invoice(enrolment, month, expiration_day) do
    invoice_value = enrolment.total_price / enrolment.invoice_quantity
    expiration_date = 
      Timex.now().year
      |> Date.new!(month, expiration_day)
      |> Date.to_string()

    %{
      enrollment_id: enrolment.id,
      expiration_date: expiration_date,
      invoice_value: invoice_value,
      status: "open"
    }
  end

  defp params_allowed(params = %{
    "course_name" => course_name,
    "invoice_quantity" => invoice_quantity,
    "student_id" => student_id,
    "institution_id" => institution_id,
    "total_price" => total_price,
    "expiration_day" => expiration_day
  }) do
    with true <- is_float(total_price),
         true <- is_number(invoice_quantity),
         true <- is_number(expiration_day),
         true <- is_binary(course_name),
         true <- !is_nil(student_id),
         true <- !is_nil(institution_id) do
      {:ok, true}
    else
      _ -> {:error, nil}
    end
  end

  defp params_allowed do nil end
end
