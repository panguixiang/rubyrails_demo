class Member::FinancialController < FatherController
  before_filter :authenticate_member!

  def index
    list = DevelDaymony.deverMonyAndInfo(current_member.id)
    @info = list[0]
    @nowTakeMoney = TakeMoney.queryGroupByMemberId(current_member.id, 3)
    nowMonth = (Time.now).strftime("%Y-%m")
    @nowMonthTax = MonthReview.queryReviewByMemberId(current_member.id,1,nowMonth)
    @developerList = DeveloperTeam.selectFieldsByMemberIdAndLeader(current_member.id,2)
    @developer_team = DeveloperTeam.new
  end

  def newDeverTeam
    @developer_team = DeveloperTeam.new(params[:developer_team])
    @developer_team.memberId=current_member.id

    list = DevelDaymony.deverMonyAndInfo(current_member.id)
    @info = list[0]
    @nowTakeMoney = TakeMoney.queryGroupByMemberId(current_member.id, 3)
    nowMonth = (Time.now).strftime("%Y-%m")
    @nowMonthTax = MonthReview.queryReviewByMemberId(current_member.id,1,nowMonth)
    @developerList = DeveloperTeam.selectFieldsByMemberIdAndLeader(current_member.id,2)

    respond_to do |format|
      if @developer_team.insertTeam(params)
        flash[:succes] = :success
        format.html { redirect_to :action => :index }
        format.json { head :no_content }
      else
        format.html { render :action => :index }
        format.json { render json: @developer_team.errors, status: :unprocessable_entity }
      end
    end
  end

  def deverWithdraw
    nowMonth = (Time.now).strftime("%Y-%m")
    @develMoney = DevelDaymony.find_by_memberId(current_member.id)
    @takedMonthLogs = TakeMoney.takedMonthLogs(3,current_member.id,nowMonth)
    if (1..5).include?((Time.now).day)
      render :deverWithdrawMsg
    end
  end

  def amount
    amount = params[:tocase]
    message = TakeMoney.caseMoney(current_member.id, amount)
    flash[:takeError]=message
    flash[:amount]=amount
    redirect_to "/member/financial/deverWithdraw"
  end

  def automatic
    render :text=> DevelDaymony.setAutoMatic(current_member.id)
  end

end
