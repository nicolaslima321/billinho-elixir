# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :billinho_elixir,
  ecto_repos: [BillinhoElixir.Repo]

# Configures the endpoint
config :billinho_elixir, BillinhoElixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HU/6eBfc2ROSwWq5alzfSFpP0WWT75f4t4w1iDwPSLo19Y10+YEjJBC3o9m6TLsz",
  render_errors: [view: BillinhoElixirWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BillinhoElixir.PubSub,
  live_view: [signing_salt: "TpS2xmg5"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
