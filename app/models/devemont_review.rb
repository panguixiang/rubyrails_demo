require 'where'
class DevemontReview < ActiveRecord::Base
  attr_accessible :id,:memberId,:month_income,:month_tax,:month_actual,:status,:created_at

  def self.get_search_query_string(memberId,startDate,endDate)
    where = Where.new
    where.and('memberId = ?', memberId)
    where.and('created_at >= ?', startDate) unless startDate.blank?
    where.and('created_at < ?', endDate) unless endDate.blank?
    where.to_s
  end

  def self.queryReviewDetails(memberId,startDate,endDate)
    sql = get_search_query_string(memberId,startDate,endDate)
    find(:all,:conditions =>sql,:order=> "created_at ASC")
  end

end
