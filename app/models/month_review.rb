class MonthReview < ActiveRecord::Base
  attr_accessible :memberId,:status,:total_income,:tax,:actual_income
  def self.queryReviewByMemberId memberId,status,month
    sql = "select tax from month_reviews where memberId=? and status = ? and DATE_FORMAT(created_at,'%Y-%m')=?"
    list = MonthReview.find_by_sql([sql,memberId,status,month])
    if list.blank?
      return 0.00
    else
      return list[0]
    end
  end
end
