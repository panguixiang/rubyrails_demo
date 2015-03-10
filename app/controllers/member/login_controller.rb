class Member::LoginController < FatherController
  before_filter :authenticate_member!,except: [:create_capte,:check_login]
  skip_filter :check_is_edit_memberInfo
  def login
    cookies[:meanId]=:a1_a11son
    cookies[:meanSonId]=:a11son
    memberId = current_member.id
    @unreadNotiList=Notifications.unreader_size(memberId)
    session[:unreadCount]=@unreadNotiList.length
    status = current_member.status
    if status==1
      @develInfo = DeveloperInfo.new
      return render 'member/login/completion'
    end
    if status==2
      return redirect_to '/member/member_info/edit'
    end
    if current_member.m_type==1 && status==3
      return redirect_to '/member/login/developerIndex'
    end
    if current_member.m_type==2 && status==3
      return redirect_to advertiser_indexs_path
    end
  end

  def create_capte
    session[:captCode]=nil? unless session[:captCode].nil?
    code = Member.create_capte_code
    session[:captCode] = code
    render :text=>code
  end


  def developerIndex
    @dayMoney = DevelDaymony.develDayMoney(current_member.id)
    if @dayMoney.blank?
      @dayMoney = DevelDaymony.new
    end
    @appStatics = AppProdu.findMemberIdGroupByStatus(current_member.id)
    @day3VistLog = AppvisitMid.query3DayMemberVistLog(current_member.id, 3)
  end

  def report7
    day7VistLog = AppvisitMid.query7DayMemberVistLog(current_member.id, 7)
    costArr=Array.new,dateArr=Array.new;
    day7VistLog.each_with_index do |vist,index|
      vist.created_at=(vist.created_at).strftime('%Y-%m-%d')
    end
    hash = Hash.new
    hash[:costArr]=day7VistLog
    hash[:weekDate]=(Chronic.parse '1 week ago').strftime('%Y-%m-%d')
    render :json=>hash.to_json
  end

  def check_login
     hash = Hash.new
    if current_member.blank?
      hash[:userName]=nil
      render :json=>hash.to_json
    else
      hash[:userName]=current_member.email
      hash[:id]=current_member.id
      render :json=>hash.to_json
    end
  end

end
