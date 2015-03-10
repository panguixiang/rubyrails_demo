module Member::TakemoneyHelper

  def getStatusStr status
    if status==1
      return "提现中"
    end
    if status==2
      return "成功！"
    end
    if status==3
      return "失败！"
    end
  end

end
