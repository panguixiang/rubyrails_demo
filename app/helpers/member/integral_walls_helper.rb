module Member::IntegralWallsHelper
  def sssssss(platform)
    if platform=='android'
      return 'display:none;'
    else
      return ""
    end
  end

  def sourceInput(platform,package_type)
    if platform=='android'
      return ''
    elsif platform=='ios' and package_type=='2'
      return ''
    else
      return 'display:none;'
    end
  end

  def urlInput(platform, package_type)
    if platform=='ios' and package_type=='1'
      return 'display:inline;'
    else
      return 'display:none;'
    end
  end

  def ishow_balance(platform)
    if platform=='android'
      return ''
    else
      return 'display:none;'
    end
  end

  def statusStr(status)
    return '运行中' if status=='1'
    return '已暂停' if status=='2'
  end

  def adverTypeStr(adverType)
    return '积分墙广告' if adverType=='1'
    return '视频广告' if adverType=='2'
  end

  def platformStr(platform)
    return 'Android' if platform=='android'
    return 'iOS' if platform=='ios'
  end

  def checkStatusStr(checkStatus)
    return '审核中' if checkStatus=='1'
    return '审核通过' if checkStatus=='2'
    return '审核未通过' if checkStatus=='2'
  end

end
