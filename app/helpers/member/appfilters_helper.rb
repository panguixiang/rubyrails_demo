module Member::AppfiltersHelper
  def appReflushTypeStr(auto_reflush)
    if auto_reflush=='2'
      return '默认2秒刷新一次'
    end
    if auto_reflush=='3'
      return '自定义刷新频率'
    end
  end

  def isShow(index,tag)
    if index=='1' and tag.blank?
      return "display: block;"
    elsif index=='1'
      return "display: none;"
    end
    if index=='2' and tag=='2'
      return "display: block;"
    elsif index=='2'
      return "display: none;"
    end
    if index=='3' and tag=='3'
      return "display: block;"
    elsif index=='3'
      return "display: none;"
    end
    if index=='4' and tag=='4'
      return "display: block;"
    elsif index=='4'
      return "display: none;"
    end
  end
end
