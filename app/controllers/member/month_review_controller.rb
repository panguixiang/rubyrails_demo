class Member::MonthReviewController < FatherController
  before_filter :authenticate_member!
  def index
    @reviewMonthList = DevemontReview.queryReviewDetails(current_member.id,
                                                    params[:startDate],params[:endDate])
  end
end
