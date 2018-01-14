defmodule JrnyPlnr.Muser do
  use Ecto.Model

  schema "muser" do
    field :uid, :string 
    field :passwd, :string
    field :gvn_name, :string
    field :mdl_name, :string
    field :fml_name, :string
    field :birth_date, :date
    field :mail, :string
  end

  import Ecto.Query
  def select_all do
    query =
      from x in JrnyPlnr.Muser,
      select: {
        x.uid,
        x.gvn_name,
        x.mdl_name, 
        x.fml_name, 
        x.birth_date,
        x.mail
      }
    JrnyPlnr.Repo.all(query)
  end

  def exists(uid) do
    query =
      from x in JrnyPlnr.Muser,
      select: {
        x.uid,
        x.gvn_name,
        x.mdl_name, 
        x.fml_name, 
        x.birth_date,
        x.mail
      },
      where:
        x.uid == ^uid,
      limit:
        1
    ret = JrnyPlnr.Repo.all(query)
    
    #NOTE another logic possibility
    if 0 < Enum.count(ret) do
      hd(ret)
    else
      nil
    end
  end

  def authenticates(uid, passwd) do
    #TODO encrypt with Erlang crypto
    encrypted_passwd = Base.encode64(passwd)
    
    #TODO cannot draw member
    query =
      from x in JrnyPlnr.Muser,
      select: {
        x.uid,
        x.gvn_name,
        x.mdl_name, 
        x.fml_name, 
        x.birth_date,
        x.mail
      },
      where:
        x.uid == ^uid
        and x.passwd == ^encrypted_passwd,
      limit:
        1
    ret = JrnyPlnr.Repo.all(query)
    
    #NOTE another logic possibility
    if 0 < Enum.count(ret) do
      hd(ret)
    else
      nil
    end
  end

  def insert(uid, passwd, gvn_name, mdl_name, fml_name, birth_date, mail) do
    #TODO encrypt with Erlang crypto
    encrypted_passwd = Base.encode64(passwd)

    usr = %JrnyPlnr.Muser{
      uid: uid,
      passwd: encrypted_passwd,
      gvn_name: gvn_name,
      mdl_name: mdl_name,
      fml_name: fml_name,
      birth_date: birth_date,
      mail: mail
    }
    JrnyPlnr.Repo.insert(usr)
  end
end

