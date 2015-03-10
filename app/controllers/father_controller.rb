class FatherController < ApplicationController
  before_filter :check_is_edit_memberInfo
  layout "member"



  def check_is_edit_memberInfo
    status = current_member.status
    if status==1
      @develInfo = DeveloperInfo.new
      return render 'member/login/completion'
    end
    if status==2
      return redirect_to '/member/member_info/edit'
    end
    return true
  end

end
