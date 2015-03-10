class Member::IntelwalStaticsController < FatherController
  before_filter :authenticate_member!

  def index
      @intelgraList = IntegralWall.select(:platform,:id,:app_name).where("memberId=?",current_member.id)
      @grouplist = @intelgraList.group_by{|s|s.platform}
      @intelId=0
  end

  def intelwalstatic
    list = IntelwallStatics.queryIntelWalStatics(current_member.id,params)
    respond_to do |format|
        format.json { render json: list.to_json}
    end
  end

  def show
    @intelgraList = IntegralWall.select(:platform,:id,:app_name).where("memberId=?",current_member.id)
    @grouplist = @intelgraList.group_by{|s|s.platform}
    @intelId=params[:id]
    render :index
  end
end
