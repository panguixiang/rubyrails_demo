class IntelwallStatics < ActiveRecord::Base
  attr_accessible :id,:memberId, :intel_id, :adver_type, :active_income, :enter_count, :relshow_count,:relclick_count,
                  :cover_count,:active_count,:play_begin,:play_finish,:created_at

  def self.get_search_query_string(memberId,intel_id,adver_type,time)
    condition=" where memberId = #{memberId}"
    condition<<" and intel_id = '#{intel_id}'" unless intel_id.blank?
    condition<<" and adver_type = '#{adver_type}'" unless adver_type.blank?
    statics_sql="select sum(s.active_income) as active_income,sum(s.enter_count) as enter_count,sum(s.relshow_count) as relshow_count,
                    sum(s.relclick_count) as relclick_count,sum(s.cover_count) as cover_count,sum(s.active_count) as active_count,sum(s.play_begin) as play_begin,
                    sum(s.play_finish) as play_finish,s.timed
                from (select
                          active_income,enter_count,relshow_count,relclick_count,cover_count,
                          active_count,play_begin,play_finish,"
    week = (Chronic.parse '1 week ago').strftime('%Y-%m-%d')
    month = (Chronic.parse '1 month ago').strftime('%Y-%m-%d')
    year = (Chronic.parse '1 year ago').strftime('%Y-%m-%d')
    if time.blank? || time==week
      statics_sql<<" date(created_at) as timed from intelwall_statics #{condition} and '#{week}' <= date(created_at)"
    elsif time==month
      statics_sql<<" date(created_at) as timed from intelwall_statics #{condition} and '#{month}' <= date(created_at)"
    elsif time==year
      statics_sql<<" date_format(created_at,'%Y-%m') as timed from intelwall_statics #{condition} and '#{year}' <= date(created_at)"
    else
      statics_sql<<" date_format(created_at,'%H%:00') as timed from intelwall_statics #{condition} and date(created_at) = '#{time}'"
    end
    statics_sql<<" ) s group by s.timed order by s.timed"
  end

  def self.queryIntelWalStatics memberId,params
    sql = get_search_query_string(memberId,params[:intel_id],params[:adver_type],params[:time])
    IntelwallStatics.find_by_sql(sql)
  end
end