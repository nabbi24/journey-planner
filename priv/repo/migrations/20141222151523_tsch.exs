defmodule JrnyPlnr.Repo.Migrations.Tsch do
  use Ecto.Migration

  def up do
    [
      "CREATE TABLE IF NOT EXISTS tsch (
        id serial,
        uid varchar(20),
        plan_no integer,
        sch_no integer,
        start_ts timestamp,
        end_ts timestamp,
        lat float,
        lng float,
        place_name varchar(60),
        detail varchar(100),
        primary key(uid, plan_no, sch_no)
      )"
    ]
  end

  def down do
    "DROP TABLE tsch"
  end
end
