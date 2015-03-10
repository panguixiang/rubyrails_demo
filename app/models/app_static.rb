class AppStatic < ActiveRecord::Base

  attr_accessible :id,:memberId,:app_id,:bill_type,:adverting_id,
                  :adverting_type,:incoming,:display_count,:request_count,
                  :fill_count,:click_count,:created_at


  def self.get_search_query_string(memberId,app_id,adverting_id,dateSele,beginDate,endDate,bill_type,adverting_type)
    condition=" where memberId = #{memberId}"
    condition<<" and app_id = '#{app_id}'" unless app_id.blank?
    condition<<" and adverting_id = '#{adverting_id}'" unless adverting_id.blank?
    unless bill_type.blank?
      if bill_type=='cpc'
        condition<<" and bill_type != 'cpm'"
      else
        condition<<" and bill_type == 'cpm'"
      end
    end
    condition<<" and adverting_type = '#{adverting_type}'" unless adverting_type.blank?
    statics_sql="select sum(s.incoming) as incoming,sum(s.display_count)
                     as display_count,sum(s.request_count) as request_count,sum(s.fill_count) as fill_count,
                    sum(s.click_count) as click_count,s.timed
                from (select
                          incoming,display_count,request_count,fill_count,click_count,"
    week = (Chronic.parse '1 week ago').strftime('%Y-%m-%d')
    month = (Chronic.parse '1 month ago').strftime('%Y-%m-%d')
    year = (Chronic.parse '1 year ago').strftime('%Y-%m-%d')
    if dateSele.blank?
      statics_sql<<" date(created_at) as timed from app_statics #{condition} "
      unless beginDate.blank?
        statics_sql<<" and date(created_at) >= '#{beginDate}' "
      end
      unless endDate.blank?
        statics_sql<<" and date(created_at) <= '#{endDate}' "
      end
    elsif dateSele==week
      statics_sql<<" date(created_at) as timed from app_statics #{condition} and '#{week}' <= date(created_at)"
    elsif dateSele==month
      statics_sql<<" date(created_at) as timed from app_statics #{condition} and '#{month}' <= date(created_at)"
    elsif dateSele==year
      statics_sql<<" date_format(created_at,'%Y-%m') as timed from app_statics #{condition} and '#{year}' <= date(created_at)"
    else
      statics_sql<<" date_format(created_at,'%H%:00') as timed from app_statics #{condition} and date(created_at) = '#{dateSele}'"
    end
    statics_sql<<" ) s group by s.timed order by s.timed"
  end

  def self.queryAppStatics memberId,params
    sql = get_search_query_string(memberId,params[:app_id],params[:adverting_id],
                                  params[:dateSele],params[:beginDate],params[:endDate],
                                  params[:bill_type],params[:adverting_type])
    AppStatic.find_by_sql(sql)
  end

end
