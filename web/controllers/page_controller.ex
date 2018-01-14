defmodule JrnyPlnr.PageController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    conn = delete_session(conn, :uid)
    render conn, "index.html"
  end

  def home(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      conn = put_session(conn, :uid, uid)
      render conn, "home.html", uid: uid
    else
      index(conn, nil)
    end
  end

  def login(conn, %{"uid" => uid, "passwd" => passwd}) do
    usr = JrnyPlnr.Muser.authenticates(uid, passwd)
    if usr != nil do
      conn = put_session(conn, :uid, uid)
      render conn, "home.html", uid: uid
    else
      render conn, "index.html", uid: uid, error: "Correct Id or password, plz."
    end
  end

  def signin(conn, _params) do
    render conn, "signin.html"
  end

  def signup(conn, %{"uid" => uid, "passwd" => passwd, "gvn_name" => gvn_name, "mdl_name" => mdl_name, "fml_name" => fml_name, "birth_date" => birth_date, "mail" => mail}) do
    #TODO error case
    if JrnyPlnr.Muser.exists(uid) == nil do 
      JrnyPlnr.Muser.insert(uid, passwd, gvn_name, mdl_name, fml_name, convert_string_to_date(birth_date), mail)
      conn = put_session(conn, :uid, uid)
      render conn, "home.html", uid: uid, gvn_name: "New comer : #{gvn_name}"
    else
      #TODO error msg
      render conn, "signin.html", error: "Your Id already exists."
    end
  end

  def plan(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      conn = put_session(conn, :uid, uid)
      render conn, "plan.html", uid: uid
    else
      index(conn, nil)
    end
  end

  def sch(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      plan = JrnyPlnr.Tplan.select_all(uid)
      #TODO transger to ajax
      sch = JrnyPlnr.Tsch.select_all(uid)
      conn = put_session(conn, :uid, uid)
      render conn, "sch.html", uid: uid, plan: plan, sch: sch
    else
      index(conn, nil)
    end
  end

  def map(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      sch = JrnyPlnr.Tsch.select_all(uid)
      conn = put_session(conn, :uid, uid)
      render conn, "map.html", uid: uid, sch: sch
    else
      index(conn, nil)
    end
  end

  def calendar(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      sch = JrnyPlnr.Tsch.select_all(uid)
      conn = put_session(conn, :uid, uid)
      render conn, "calendar.html", uid: uid, sch: sch
    else
      index(conn, nil)
    end
  end

  def pears(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      conn = put_session(conn, :uid, uid)
      render conn, "pears.html", uid: uid
    else
      index(conn, nil)
    end
  end

  def comm(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      conn = put_session(conn, :uid, uid)
      render conn, "comm.html", uid: uid
    else
      index(conn, nil)
    end
  end

  def profile(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      conn = put_session(conn, :uid, uid)
      render conn, "profile.html", uid: uid
    else
      index(conn, nil)
    end
  end

  def ins_sch(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      JrnyPlnr.Tsch.insert(uid, String.to_integer(_params["plan_no"]), convert_string_to_datetime(_params["start_ts"]), convert_string_to_datetime(_params["end_ts"]), String.to_float(_params["lat"]), String.to_float(_params["lng"]), _params["place_name"], _params["detail"])
      sch = JrnyPlnr.Tsch.select_all(uid)
      conn = put_session(conn, :uid, uid)
      render conn, "map.html", uid: uid, sch: sch
    else
      index(conn, nil)
    end
  end

  def upd_sch(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      JrnyPlnr.Tsch.update(uid, String.to_integer(_params["plan_no"]), String.to_integer(_params["sch_no"]), convert_string_to_datetime(_params["start_ts"]), convert_string_to_datetime(_params["end_ts"]), _params["place_name"], _params["detail"])
      conn = put_session(conn, :uid, uid)
      json conn, 201
    else
      index(conn, nil)
    end
  end

  def del_sch(conn, _params) do
    uid = get_session(conn, :uid)
    if uid != nil do
      JrnyPlnr.Tsch.delete(uid, String.to_integer(_params["plan_no"]), String.to_integer(_params["sch_no"]))
      conn = put_session(conn, :uid, uid)
      json conn, 201
    else
      index(conn, nil)
    end
  end

  def not_found(conn, _params) do
    render conn, "not_found.html"
  end

  def error(conn, _params) do
    conn = delete_session(conn, :uid)
    render conn, "error.html"
  end

  defp convert_string_to_date(date) do
    ymd = String.split(date, "/")
    #TODO condition
    if Enum.count(ymd) == 3 do
      %Ecto.Date{year: String.to_integer(Enum.at(ymd, 0)), month: String.to_integer(Enum.at(ymd, 1)), day: String.to_integer(Enum.at(ymd, 2))}
    else
      nil
    end
  end

  defp convert_string_to_datetime(datetime) do
    dt = String.split(datetime, " ")
    ymd = String.split(Enum.at(dt, 0), "/")
    hm = String.split(Enum.at(dt, 1), ":")
    #TODO condition
    if Enum.count(ymd) == 3 and Enum.count(hm) == 2 do
      %Ecto.DateTime{year: String.to_integer(Enum.at(ymd, 0)), month: String.to_integer(Enum.at(ymd, 1)), day: String.to_integer(Enum.at(ymd, 2)), hour: String.to_integer(Enum.at(hm, 0)), min: String.to_integer(Enum.at(hm, 1)), sec: 0}
    else
      nil
    end
  end

end
