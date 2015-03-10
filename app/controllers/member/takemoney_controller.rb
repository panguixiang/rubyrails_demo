class Member::TakemoneyController < FatherController
  before_filter :authenticate_member!
  def index
    @takeMoneyList = TakeMoney.queryTakeMoneys(current_member.id,
                                                    params[:startDate],params[:endDate])
  end
end
