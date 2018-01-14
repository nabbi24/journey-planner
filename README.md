# JourneyPlanner

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.


get ready Postgresql:

1. yum install postgresql
2. createuser -a -d -U jrnyplnr_db -P jrnyplnr
3. psql jrnyplnr_db jrny_plnr

get ready Ecto:

1. mix ecto.gen.migration JrnyPlnr.Repo table_name
2. mix ecto.rollback JrnyPlnr.Repo --all
3. mix ecto.migrate JrnyPlnr.Repo --all

start phoenix:

1. $ cd jrny_plnr
2. mix do deps.get
3. mix do clean, compile, phoenix.start

git push:

1. git status
2. git add .
3. git commit -m "comment"
4. git push