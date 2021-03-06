# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :idService,
  ecto_repos: [IdService.Repo]

# Configures the endpoint
config :idService, IdServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TxIf/ANULBICc6pkL2k80bzJ2jtj96g9A3vPcXUtxkKbj5Gg73mhieOFfTwDa2l7",
  render_errors: [view: IdServiceWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: IdService.PubSub,
  live_view: [signing_salt: "QEZVPcir"]

config :idService, IdService.Guardian,
  issuer: "idService",
  secret_key: "aeLTgFeQ9xCtkubmeUAn7x1PE4pDS9oh78zKd1bt+NwBJs0xsoP5uBPMSWLc0q6X"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
