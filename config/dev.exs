use Mix.Config

config :jrny_plnr, JrnyPlnr.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true

# Enables code reloading for development
config :phoenix, :code_reloader, true
