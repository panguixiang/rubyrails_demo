require 'where'
class Adprodstatic < ActiveRecord::Base

  def self.get_search_query_string(memberId,bill_type,planName)
    where = Where.new
    where.and('b.adver_memberId = ?', memberId) unless memberId.blank?
    where.and('a.bill_type = ?', bill_type) unless bill_type.blank?
    where.and('b.adver_plan_name like ?', planName ) unless planName.blank?
    where.to_s
  end

  def self.queryFinances memberId,bill_type,planName,page

    sql="select c.*,sum(case when d.cost!=null then d.cost else 0 end) as cost,"
    sql<<"sum(case when d.clickNum!=null then d.clickNum else 0 end) as clickNum,"
    sql<<"sum(case when d.displaynum!=null then d.displaynum else 0 end) as displaynum,"
    sql<<"sum(case when d.download_count!=null then d.download_count else 0 end) as download_count,"
    sql<<"sum(case when d.install_count!=null then d.install_count else 0 end) as install_count "
    sql<<"from (select a.id,a.budget_day,a.buget,b.adver_plan_name,a.bill_type from "
    sql<<"adver_plan_groups a left join adprods b on a.adverId=b.id where "
    sql<<get_search_query_string(memberId,bill_type,planName)
    sql<<" order by b.created_at desc ) c left join adprodstatics d "
    sql<<"on c.id=d.adver_gro_id group by c.id limit ? offset ?"
    Adprodstatic.find_by_sql([sql,page.getPageLimit,page.getOffSet])

  end

  def self.queryAdplanCount(memberId,bill_type,planName)
    sql="select c.id from (select a.id from adver_plan_groups a left join adprods b on a.adverId=b.id where "
    sql<<get_search_query_string(memberId,bill_type,planName)
    sql<<" ) c left join adprodstatics d on c.id=d.adver_gro_id group by c.id"
    Adprodstatic.find_by_sql(sql).count
  end






  def self.get_search_query_string1(adver_memberId,adverIds,adver_gro_ids,adver_orig_ids,bill_type,dateSele,beginDate,endDate)
    condition="where adver_memberId = #{adver_memberId}"
    condition<<" and adverId in (#{adverIds}) " unless adverIds.blank?
    condition<<" and adver_gro_id in (#{adver_gro_ids})" unless adver_gro_ids.blank?
    condition<<" and adver_orig_id in (#{adver_orig_ids})" unless adver_orig_ids.blank?
    condition<<" and bill_type = '#{bill_type}'" unless bill_type.blank?
    statics_sql="select sum(s.cost) as cost,sum(s.displaynum)
                     as displaynum,sum(s.clickNum) as clickNum,sum(s.install_count) as install_count,
                    sum(s.download_count) as download_count,timed
                from (select
                          cost,displaynum,clickNum,install_count,download_count,"
    week = (Chronic.parse '1 week ago').strftime('%Y-%m-%d')
    month = (Chronic.parse '1 month ago').strftime('%Y-%m-%d')
    year = (Chronic.parse '1 year ago').strftime('%Y-%m-%d')
    if dateSele.blank?
      statics_sql<<" date(created_at) as timed from adprodstatics #{condition} "
      unless beginDate.blank?
        statics_sql<<" and date(created_at) >= '#{beginDate}' "
      end
      unless endDate.blank?
        statics_sql<<" and date(created_at) <= '#{endDate}' "
      end
    elsif dateSele==week
      statics_sql<<" date(created_at) as timed from adprodstatics #{condition} and '#{week}' <= date(created_at)"
    elsif dateSele==month
      statics_sql<<" date(created_at) as timed from adprodstatics #{condition} and '#{month}' <= date(created_at)"
    elsif dateSele==year
      statics_sql<<" date_format(created_at,'%Y-%m') as timed from adprodstatics #{condition} and '#{year}' <= date(created_at)"
    else
      statics_sql<<" date_format(created_at,'%H%:00') as timed from adprodstatics #{condition} and date(created_at) = '#{dateSele}'"
    end
    statics_sql<<" ) s group by s.timed order by s.timed"
  end

  def self.queryAdvStatics adver_memberId,params
    sql = get_search_query_string1(adver_memberId,params[:adverIds],params[:adver_gro_ids],params[:adver_orig_ids],
                                  params[:bill_type],params[:dateSele],params[:beginDate],params[:endDate])
    Adprodstatic.find_by_sql(sql)
  end

  def self.queryAdprods adverMemberId
    sql="select id,adver_plan_name,status from adprods where adver_memberId = #{adverMemberId} "
    Adprod.find_by_sql(sql)
  end

  def self.queryAdver_plan_group adverId
    list=AdverPlanGroup.select("id,group_name,status ").where(adverId: adverId)
    return list
  end

  def self.queryAdver_group_originality adverId1,adverId
    list=AdverGroupOriginality.select("id,title,status ").where(adver_gro_id: adverId1,adverId: adverId )
    return list
  end

end
