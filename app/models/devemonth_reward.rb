class DevemonthReward < ActiveRecord::Base
  attr_accessible :id,:memberId,:rewincome,:rewdescrip,:rn,:created_at

  def self.get_search_query_string(memberId,startDate,endDate)
    where = Where.new
    where.and('memberId = ?', memberId)
    where.and('created_at >= ?', startDate) unless startDate.blank?
    where.and('created_at < ?', endDate) unless endDate.blank?
    where.to_s
  end

  def self.queryRewards(memberId,startDate,endDate)
    sql = get_search_query_string(memberId,startDate,endDate)
    find(:all,:conditions =>sql,:order=> "created_at ASC")
  end
end
