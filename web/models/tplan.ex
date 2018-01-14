defmodule JrnyPlnr.Tplan do
  use Ecto.Model

  schema "tplan" do
    field :uid, :string
    field :plan_no, :integer
    field :plan_name, :string
    field :detail, :string
  end

  def select_all(uid) do
    query =
      from x in JrnyPlnr.Tplan,
      select: x,
      where: x.uid == ^uid,
      order_by: [x.plan_no]
    JrnyPlnr.Repo.all(query)
  end

  def select(uid, plan_no) do
    query =
      from x in JrnyPlnr.Tplan,
      select: x,
      where: x.uid == ^uid and x.plan_no == ^plan_no 
    JrnyPlnr.Repo.all(query)
  end

  defp select_next_plan_no(uid) do
    query =
      from x in JrnyPlnr.Tplan,
      select: max(x.plan_no) + 1,
      where: x.uid == ^uid
    ret = JrnyPlnr.Repo.all(query)
    #TODO condition
    if ret != nil and 0 < Enum.count(ret) do hd(ret) else 1 end
  end

  def insert(uid, plan_name, detail) do
    plan_no = select_next_plan_no(uid)
    sch = %JrnyPlnr.Tplan{
      uid: uid,
      plan_no: plan_no,
      plan_name: plan_name,
      detail: detail
    }
    JrnyPlnr.Repo.insert(sch)
  end

  def update(uid, plan_no, plan_name, detail) do
    [plan] = JrnyPlnr.Repo.all(from x in JrnyPlnr.Tplan, where: x.uid == ^uid and x.plan_no == ^plan_no)
    plan = %{plan | plan_name: plan_name, detail: detail}
    JrnyPlnr.Repo.update(plan)
  end

  def delete(uid, plan_no) do
    [plan] = JrnyPlnr.Repo.all(from x in JrnyPlnr.Tplan, where: x.uid == ^uid and x.plan_no == ^plan_no)
    JrnyPlnr.Repo.delete(plan)
  end
end
