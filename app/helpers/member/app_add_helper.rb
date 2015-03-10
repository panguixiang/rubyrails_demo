module Member::AppAddHelper

  def appTypeStr(appType)
    if appType=='100'
      return '动作格斗'
    end
    if appType=='101'
      return '休闲益智'
    end
    if appType=='102'
      return '体育竞技'
    end
    if appType=='103'
      return '角色扮演'
    end
    if appType=='104'
      return '模拟经营'
    end
    if appType=='105'
      return '其它游戏'
    end
    if appType=='106'
      return '影音播放'
    end
    if appType=='107'
      return '安全软件'
    end
    if appType=='108'
      return '网络通讯'
    end
    if appType=='109'
      return '实用工具'
    end
    if appType=='110'
      return '系统软件'
    end
    if appType=='111'
      return '生活天气'
    end
    if appType=='112'
      return '娱乐休闲'
    end
    if appType=='113'
      return '电子阅读'
    end
    if appType=='114'
      return '主题桌面'
    end
    if appType=='115'
      return '新闻杂志'
    end
    if appType=='116'
      return '交通导航'
    end
    if appType=='117'
      return '医疗健康'
    end
    if appType=='118'
      return '学习办公'
    end
    if appType=='119'
      return '摄影录像'
    end
    if appType=='120'
      return '金融理财'
    end
    if appType=='121'
      return '其它应用'
    end
  end

  def adverStatusStr status
    if status==1
      return '允许'
    elsif status=='2'
      return '暂停'
    end
  end


end
