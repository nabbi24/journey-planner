defmodule JrnyPlnr.Repo.Migrations.Tplan do
  use Ecto.Migration

  def up do
    [
      "CREATE TABLE IF NOT EXISTS tplan (
        id serial,
        uid varchar(20),
        plan_no integer,
        plan_name varchar(40),
        detail varchar(160),
        primary key(uid, plan_no)
      )"
    ]
  end

  def down do
    "DROP TABLE tplan"
  end
end
