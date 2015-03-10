class Member::RewardController  < FatherController
  before_filter :authenticate_member!
  def index
    @rewardMoneyList = DevemonthReward.queryRewards(current_member.id,
                                                  params[:startDate],params[:endDate])
  end
end
