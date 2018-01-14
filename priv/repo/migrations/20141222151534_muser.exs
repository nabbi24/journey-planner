defmodule JrnyPlnr.Repo.Migrations.Muser do
  use Ecto.Migration

  def up do
    [
      "CREATE TABLE IF NOT EXISTS muser (
        id serial,
        uid varchar(20),
        passwd varchar(160),
        gvn_name varchar(40),
        mdl_name varchar(40),
        fml_name varchar(40),
        birth_date date,
        mail varchar(120),
        primary key(uid)
      )"
    ]
  end

  def down do
    "DROP TABLE muser"
  end
end
