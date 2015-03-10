class Member::IncomeController < FatherController
  before_filter :authenticate_member!
  def index
    @incomeList = RevenceDetail.queryRevenceDetails(current_member.id,
                                                    params[:startDate],params[:endDate])
  end
end
