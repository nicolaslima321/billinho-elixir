defmodule BillinhoElixirWeb.InstitutionView do
  use BillinhoElixirWeb, :view
  alias BillinhoElixirWeb.InstitutionView

  def render("index.json", %{institutions: institutions}) do
    %{data: render_many(institutions, InstitutionView, "institution.json")}
  end

  def render("show.json", %{institution: institution}) do
    %{data: render_one(institution, InstitutionView, "institution.json")}
  end

  def render("institution.json", %{institution: institution}) do
    %{id: institution.id,
      name: institution.name,
      cnpj: institution.cnpj,
      kind: institution.kind}
  end
end
