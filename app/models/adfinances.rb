require 'where'
class Adfinances < ActiveRecord::Base

  def self.get_search_query_string(memberId,date)
    where = Where.new
    where.and('memberId = ?', memberId) unless memberId.blank?
    if date.blank?
      where.and("#{(Chronic.parse '1 week ago').strftime('%Y-%m-%d')} <= date(created_at) ")
      return where.to_s
    end
    dateArr = date.split('-')
    if dateArr.length==3
      where.and("'#{date}' = date(created_at) ")
    elsif dateArr.length==6
      beginDate=dateArr[0]+"-"+dateArr[1]+"-"+dateArr[2]
      endDate=dateArr[3]+"-"+dateArr[4]+"-"+dateArr[5]
      where.and("'#{beginDate}' <= date(created_at) ")
      where.and("'#{endDate}' >= date(created_at) ")
    end
    return where.to_s
  end

  def self.queryFinances memberId,date
    sql="select * from adfinances where "
    sql<<get_search_query_string(memberId, date)
    find_by_sql(sql)
  end
end
