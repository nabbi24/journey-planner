defmodule JrnyPlnr.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url "ecto://jrnyplnr:rnlpynrj1@localhost/jrnyplnr_db"
  end

  def priv do
    app_dir(:jrny_plnr, "priv/repo")
  end
end
