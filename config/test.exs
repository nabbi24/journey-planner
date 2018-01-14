use Mix.Config

config :jrny_plnr, JrnyPlnr.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
