use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :jrny_plnr, JrnyPlnr.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  #http: [host: "journeyplanner.server-on.net", port: 4000],
  #url: [host: "journeyplanner.server-on.net", port: 80],
  secret_key_base: "{key}"

config :logger,
  level: :info
