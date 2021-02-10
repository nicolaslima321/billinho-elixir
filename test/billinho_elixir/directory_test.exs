defmodule BillinhoElixir.DirectoryTest do
  use BillinhoElixir.DataCase

  alias BillinhoElixir.Directory

  describe "institutions" do
    alias BillinhoElixir.Directory.Institution

    @valid_attrs %{cnpj: "some cnpj", kind: "some kind", name: "some name"}
    @update_attrs %{cnpj: "some updated cnpj", kind: "some updated kind", name: "some updated name"}
    @invalid_attrs %{cnpj: nil, kind: nil, name: nil}

    def institution_fixture(attrs \\ %{}) do
      {:ok, institution} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_institution()

      institution
    end

    test "list_institutions/0 returns all institutions" do
      institution = institution_fixture()
      assert Directory.list_institutions() == [institution]
    end

    test "get_institution!/1 returns the institution with given id" do
      institution = institution_fixture()
      assert Directory.get_institution!(institution.id) == institution
    end

    test "create_institution/1 with valid data creates a institution" do
      assert {:ok, %Institution{} = institution} = Directory.create_institution(@valid_attrs)
      assert institution.cnpj == "some cnpj"
      assert institution.kind == "some kind"
      assert institution.name == "some name"
    end

    test "create_institution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_institution(@invalid_attrs)
    end

    test "update_institution/2 with valid data updates the institution" do
      institution = institution_fixture()
      assert {:ok, %Institution{} = institution} = Directory.update_institution(institution, @update_attrs)
      assert institution.cnpj == "some updated cnpj"
      assert institution.kind == "some updated kind"
      assert institution.name == "some updated name"
    end

    test "update_institution/2 with invalid data returns error changeset" do
      institution = institution_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_institution(institution, @invalid_attrs)
      assert institution == Directory.get_institution!(institution.id)
    end

    test "delete_institution/1 deletes the institution" do
      institution = institution_fixture()
      assert {:ok, %Institution{}} = Directory.delete_institution(institution)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_institution!(institution.id) end
    end

    test "change_institution/1 returns a institution changeset" do
      institution = institution_fixture()
      assert %Ecto.Changeset{} = Directory.change_institution(institution)
    end
  end

  describe "students" do
    alias BillinhoElixir.Directory.Student

    @valid_attrs %{birth_date: ~N[2010-04-17 14:00:00], celphone: 42, cpf: "some cpf", genre: "some genre", name: "some name", payment_method: "some payment_method"}
    @update_attrs %{birth_date: ~N[2011-05-18 15:01:01], celphone: 43, cpf: "some updated cpf", genre: "some updated genre", name: "some updated name", payment_method: "some updated payment_method"}
    @invalid_attrs %{birth_date: nil, celphone: nil, cpf: nil, genre: nil, name: nil, payment_method: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Directory.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Directory.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Directory.create_student(@valid_attrs)
      assert student.birth_date == ~N[2010-04-17 14:00:00]
      assert student.celphone == 42
      assert student.cpf == "some cpf"
      assert student.genre == "some genre"
      assert student.name == "some name"
      assert student.payment_method == "some payment_method"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = Directory.update_student(student, @update_attrs)
      assert student.birth_date == ~N[2011-05-18 15:01:01]
      assert student.celphone == 43
      assert student.cpf == "some updated cpf"
      assert student.genre == "some updated genre"
      assert student.name == "some updated name"
      assert student.payment_method == "some updated payment_method"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_student(student, @invalid_attrs)
      assert student == Directory.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Directory.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Directory.change_student(student)
    end
  end

  describe "enrollments" do
    alias BillinhoElixir.Directory.Enrollment

    @valid_attrs %{course_name: "some course_name", institution_id: 42, invoice_quantity: 42, student_id: 42, total_price: 120.5}
    @update_attrs %{course_name: "some updated course_name", institution_id: 43, invoice_quantity: 43, student_id: 43, total_price: 456.7}
    @invalid_attrs %{course_name: nil, institution_id: nil, invoice_quantity: nil, student_id: nil, total_price: nil}

    def enrollment_fixture(attrs \\ %{}) do
      {:ok, enrollment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_enrollment()

      enrollment
    end

    test "list_enrollments/0 returns all enrollments" do
      enrollment = enrollment_fixture()
      assert Directory.list_enrollments() == [enrollment]
    end

    test "get_enrollment!/1 returns the enrollment with given id" do
      enrollment = enrollment_fixture()
      assert Directory.get_enrollment!(enrollment.id) == enrollment
    end

    test "create_enrollment/1 with valid data creates a enrollment" do
      assert {:ok, %Enrollment{} = enrollment} = Directory.create_enrollment(@valid_attrs)
      assert enrollment.course_name == "some course_name"
      assert enrollment.institution_id == 42
      assert enrollment.invoice_quantity == 42
      assert enrollment.student_id == 42
      assert enrollment.total_price == 120.5
    end

    test "create_enrollment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_enrollment(@invalid_attrs)
    end

    test "update_enrollment/2 with valid data updates the enrollment" do
      enrollment = enrollment_fixture()
      assert {:ok, %Enrollment{} = enrollment} = Directory.update_enrollment(enrollment, @update_attrs)
      assert enrollment.course_name == "some updated course_name"
      assert enrollment.institution_id == 43
      assert enrollment.invoice_quantity == 43
      assert enrollment.student_id == 43
      assert enrollment.total_price == 456.7
    end

    test "update_enrollment/2 with invalid data returns error changeset" do
      enrollment = enrollment_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_enrollment(enrollment, @invalid_attrs)
      assert enrollment == Directory.get_enrollment!(enrollment.id)
    end

    test "delete_enrollment/1 deletes the enrollment" do
      enrollment = enrollment_fixture()
      assert {:ok, %Enrollment{}} = Directory.delete_enrollment(enrollment)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_enrollment!(enrollment.id) end
    end

    test "change_enrollment/1 returns a enrollment changeset" do
      enrollment = enrollment_fixture()
      assert %Ecto.Changeset{} = Directory.change_enrollment(enrollment)
    end
  end

  describe "invoices" do
    alias BillinhoElixir.Directory.Invoice

    @valid_attrs %{enrollment_id: 42, expiration_date: ~N[2010-04-17 14:00:00], invoice_value: 120.5, status: "some status"}
    @update_attrs %{enrollment_id: 43, expiration_date: ~N[2011-05-18 15:01:01], invoice_value: 456.7, status: "some updated status"}
    @invalid_attrs %{enrollment_id: nil, expiration_date: nil, invoice_value: nil, status: nil}

    def invoice_fixture(attrs \\ %{}) do
      {:ok, invoice} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_invoice()

      invoice
    end

    test "list_invoices/0 returns all invoices" do
      invoice = invoice_fixture()
      assert Directory.list_invoices() == [invoice]
    end

    test "get_invoice!/1 returns the invoice with given id" do
      invoice = invoice_fixture()
      assert Directory.get_invoice!(invoice.id) == invoice
    end

    test "create_invoice/1 with valid data creates a invoice" do
      assert {:ok, %Invoice{} = invoice} = Directory.create_invoice(@valid_attrs)
      assert invoice.enrollment_id == 42
      assert invoice.expiration_date == ~N[2010-04-17 14:00:00]
      assert invoice.invoice_value == 120.5
      assert invoice.status == "some status"
    end

    test "create_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_invoice(@invalid_attrs)
    end

    test "update_invoice/2 with valid data updates the invoice" do
      invoice = invoice_fixture()
      assert {:ok, %Invoice{} = invoice} = Directory.update_invoice(invoice, @update_attrs)
      assert invoice.enrollment_id == 43
      assert invoice.expiration_date == ~N[2011-05-18 15:01:01]
      assert invoice.invoice_value == 456.7
      assert invoice.status == "some updated status"
    end

    test "update_invoice/2 with invalid data returns error changeset" do
      invoice = invoice_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_invoice(invoice, @invalid_attrs)
      assert invoice == Directory.get_invoice!(invoice.id)
    end

    test "delete_invoice/1 deletes the invoice" do
      invoice = invoice_fixture()
      assert {:ok, %Invoice{}} = Directory.delete_invoice(invoice)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_invoice!(invoice.id) end
    end

    test "change_invoice/1 returns a invoice changeset" do
      invoice = invoice_fixture()
      assert %Ecto.Changeset{} = Directory.change_invoice(invoice)
    end
  end
end
