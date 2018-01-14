defmodule JrnyPlnr.Endpoint do
  use Phoenix.Endpoint, otp_app: :jrny_plnr

  plug Plug.Static,
    at: "/", from: :jrny_plnr

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_jrny_plnr_key",
    signing_salt: "OxUFoAMA",
    encryption_salt: "5N1FWM9m"

  plug :router, JrnyPlnr.Router
end
