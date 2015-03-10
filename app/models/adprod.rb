class Adprod < ActiveRecord::Base

  def self.queryAdProdStatics(memberId)
    sql = "select s.id,s.adver_plan_name,s.adver_memberId,"
    sql<<"sum(case when s.displaynum!=null then s.displaynum else 0 end) as displaynum,"
    sql<<"sum(case when s.clickNum!=null then s.clickNum else 0 end) as clickNum,"
    sql<<"sum(case when s.cost!=null then s.cost else 0 end) as cost,"
    sql<<"sum(case when s.bill_type='cpc' then s.cost else 0 end) as cpc_cost,"
    sql<<"sum(case when s.bill_type='cpm' then s.cost else 0 end) as cpm_cost from (select "
    sql<<"a.id,a.adver_plan_name,a.adver_memberId,d.displaynum,d.clickNum,d.bill_type,d.cost as cost "
    sql<<"from adprods a left join adprodstatics d on a.id=d.adverId where a.adver_memberId=?) s group by s.id"
    find_by_sql([sql,memberId])
  end

end
