# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console,
  format: "$time $metadata[$level] $levelpad$message\n",
  level: :warn
