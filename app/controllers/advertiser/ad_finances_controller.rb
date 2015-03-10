class Advertiser::AdFinancesController < FatherController
  before_filter :authenticate_member!

  def index
    memberId=current_member.id
    @adfinanceList = Adfinances.queryFinances(memberId, params[:date])
    @adfinanceCount=@adfinanceList.length
    all=0
    @adfinanceList.each do |m|
      all+=m.consumday
    end
    @consumdayTall=all
  end
end
