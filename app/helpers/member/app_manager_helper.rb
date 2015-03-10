module Member::AppManagerHelper

  def adver_TypeStr(adverType)
    if adverType==1
      return 'inline广告位'
    end
    if adverType==2
      return '普通插屏广告位'
    end
    if adverType==3
      return '开屏广告位'
    end
    if adverType==4
      return '信息流顶部广告位'
    end
    if adverType==5
      return '多宝屋广告位'
    end
    if adverType==6
      return 'Native广告位'
    end
  end

  def adPositionStatus(status)
    if status==1
      return '运行'
    end
    if status==2
      return '暂停'
    end
  end

  def appStatusStr(status)
    if status==1
      return '未上传应用'
    end
    if status==2
      return '应用审核中'
    end
    if status==3
      return '审核未通过'
    end
    if status==4
      return '运行中'
    end
    if status==5
      return '暂停中'
    end
    if status==6
      return '已禁用'
    end
  end

  def appFilterTypeStr(dddd)
    if dddd=='0'
      str1='显示所有广告创意类型'
    else
      arr = dddd
      str1='不展示'
      if arr.include?('1')
        str1+='文本广告,'
      end
      if arr.include?('2')
        str1+='图片广告,'
      end
      if arr.include?('3')
        str1+='gif动画广告,'
      end
      if arr.include?('4')
        str1+='长文本广告,'
      end
      if arr.include?('5')
        str1+='视频广告,'
      end
      if arr.include?('6')
        str1+='HTML5富媒体广告,'
      end
    end
    return str1
  end

  def calculateTotal appList
    if appList.blank?
      return '<th class="right tdIncome">0.00</th><th class="right tdShow">0</th>
              <th class="right tdEcpm">0</th>'
    else
      incoming=0.000
      display=0
      appList.each do |obj|
        incoming+=obj.incoming unless (obj.incoming).blank?
        display+=obj.display_count unless (obj.display_count).blank?
      end
      ecpm=0.00
      if display>0
        ecpm = (incoming/display)*1000
      end
      return "<th class='right tdIncome'>#{number_with_precision(incoming)}</th>
          <th class='right tdShow'>#{display}</th>
          <th class='right tdEcpm'>#{number_with_precision(ecpm)}</th>"
    end
  end
end
