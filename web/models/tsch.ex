defmodule JrnyPlnr.Tsch do
  use Ecto.Model

  schema "tsch" do
    field :uid, :string
    field :plan_no, :integer
    field :sch_no, :integer
    field :start_ts, :datetime
    field :end_ts, :datetime
    field :lat, :float
    field :lng, :float
    field :place_name, :string
    field :detail, :string
  end

  def select_all(uid) do
    query =
      from x in JrnyPlnr.Tsch,
      select: x,
      where: x.uid == ^uid,
      order_by: [x.uid, x.plan_no, x.sch_no]
    JrnyPlnr.Repo.all(query)
  end

  defp select_next_sch_no(uid, plan_no) do
    query =
      from x in JrnyPlnr.Tsch,
      select: max(x.sch_no) + 1,
      where: x.uid == ^uid and x.plan_no == ^plan_no
    ret = JrnyPlnr.Repo.all(query)
    #TODO condition
    if ret != nil and 0 < Enum.count(ret) do hd(ret) else 1 end
  end

  def insert(uid, plan_no, start_ts, end_ts, lat, lng, place_name, detail) do
    sch_no = select_next_sch_no(uid, plan_no)
    sch = %JrnyPlnr.Tsch{
      uid: uid,
      plan_no: plan_no,
      sch_no: sch_no,
      start_ts: start_ts,
      end_ts: end_ts,
      lat: lat,
      lng: lng,
      place_name: place_name,
      detail: detail
    }
    JrnyPlnr.Repo.insert(sch)
  end

  def update(uid, plan_no, sch_no, start_ts, end_ts, place_name, detail) do
    [sch] = JrnyPlnr.Repo.all(from x in JrnyPlnr.Tsch, where: x.uid == ^uid and x.plan_no == ^plan_no and x.sch_no == ^sch_no)
    sch = %{sch | start_ts: start_ts, end_ts: end_ts, place_name: place_name, detail: detail}
    JrnyPlnr.Repo.update(sch)
  end

  def delete(uid, plan_no, sch_no) do
    [sch] = JrnyPlnr.Repo.all(from x in JrnyPlnr.Tsch, where: x.uid == ^uid and x.plan_no == ^plan_no and x.sch_no == ^sch_no)
    JrnyPlnr.Repo.delete(sch)
  end
end
