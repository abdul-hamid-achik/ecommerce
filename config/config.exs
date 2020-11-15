# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ecommerce,
  ecto_repos: [Ecommerce.Repo]

# Configures the endpoint
config :ecommerce, EcommerceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EkAFz31MvohYwHdNqI0x/8YAUHluEAzhtI4srh6XuWv6Pl6fSENGnWIIO5T4heEn",
  render_errors: [view: EcommerceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ecommerce.PubSub,
  live_view: [signing_salt: "/ungeFER"]

config :waffle,
  storage: Waffle.Storage.Local,
  # or {:system, "ASSET_HOST"}
  asset_host: "http://localhost:4000"

config :ecommerce, :pow,
  user: Ecommerce.Users.User,
  repo: Ecommerce.Repo,
  web_module: EcommerceWeb

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
