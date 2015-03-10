class Advertiser::IndexsController < FatherController
  before_filter :authenticate_member!

  def index
    @adBalance = Adfinances.select(:now_balance,:consumday)
      .where("memberId=?",current_member.id).last
    @adProStatics = Adprod.queryAdProdStatics current_member.id
  end

  def reportWeek
    adBalanceList = Adfinances.select(:consumday,:created_at)
    .where("memberId=?",current_member.id).order(:id)
    hash = Hash.new
    hash[:costArr]=adBalanceList
    hash[:weekDate]=(Chronic.parse '1 week ago').strftime('%Y-%m-%d')
    respond_to do |format|
      format.json { render json: hash.to_json}
    end
  end

end
