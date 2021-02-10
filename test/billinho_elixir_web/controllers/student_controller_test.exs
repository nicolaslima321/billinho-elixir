defmodule BillinhoElixirWeb.StudentControllerTest do
  use BillinhoElixirWeb.ConnCase

  alias BillinhoElixir.Directory
  alias BillinhoElixir.Directory.Student

  @create_attrs %{
    birth_date: ~N[2010-04-17 14:00:00],
    celphone: 42,
    cpf: "some cpf",
    genre: "some genre",
    name: "some name",
    payment_method: "some payment_method"
  }
  @update_attrs %{
    birth_date: ~N[2011-05-18 15:01:01],
    celphone: 43,
    cpf: "some updated cpf",
    genre: "some updated genre",
    name: "some updated name",
    payment_method: "some updated payment_method"
  }
  @invalid_attrs %{birth_date: nil, celphone: nil, cpf: nil, genre: nil, name: nil, payment_method: nil}

  def fixture(:student) do
    {:ok, student} = Directory.create_student(@create_attrs)
    student
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all students", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create student" do
    test "renders student when data is valid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.student_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2010-04-17T14:00:00",
               "celphone" => 42,
               "cpf" => "some cpf",
               "genre" => "some genre",
               "name" => "some name",
               "payment_method" => "some payment_method"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update student" do
    setup [:create_student]

    test "renders student when data is valid", %{conn: conn, student: %Student{id: id} = student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.student_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2011-05-18T15:01:01",
               "celphone" => 43,
               "cpf" => "some updated cpf",
               "genre" => "some updated genre",
               "name" => "some updated name",
               "payment_method" => "some updated payment_method"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, student: student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete student" do
    setup [:create_student]

    test "deletes chosen student", %{conn: conn, student: student} do
      conn = delete(conn, Routes.student_path(conn, :delete, student))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.student_path(conn, :show, student))
      end
    end
  end

  defp create_student(_) do
    student = fixture(:student)
    %{student: student}
  end
end
