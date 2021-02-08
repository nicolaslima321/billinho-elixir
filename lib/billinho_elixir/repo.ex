defmodule BillinhoElixir.Repo do
  use Ecto.Repo,
    otp_app: :billinho_elixir,
    adapter: Ecto.Adapters.Postgres
end
