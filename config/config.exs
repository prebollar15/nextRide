# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nextRide,
  ecto_repos: [NextRide.Repo]

# Configures the endpoint
config :nextRide, NextRideWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "okgxSTZ/UQ3AIygoEbf5k31whVd5xCZdAI1+Nop0maJuGZgo870CIS/6i4Gxk5ne",
  render_errors: [view: NextRideWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NextRide.PubSub,
  live_view: [signing_salt: "hzAYRou2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user, public_repo"]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_SECRET_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
