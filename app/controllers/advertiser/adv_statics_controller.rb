class Advertiser::AdvStaticsController < FatherController
  before_filter :authenticate_member!
  def index
    @adprodsList=Adprodstatic.queryAdprods(current_member.id)
    unless @adprodsList.blank?
      adId=Array.new
      @adprodsList.each_with_index do |value, index|
        adId[index]=value.id
      end
      @adver_plan_groupList=Adprodstatic.queryAdver_plan_group(adId)
    end
    unless @adver_plan_groupList.blank?
      adId1=Array.new
      @adver_plan_groupList.each_with_index do |value, index|
        adId1[index]=value.id
      end
      @adver_group_originalityList=Adprodstatic.queryAdver_group_originality(adId1,adId)
    end
  end



  def advstatic
    list = Adprodstatic.queryAdvStatics(current_member.id,params)
    respond_to do |format|
       format.json { render json: list.to_json}
     end
  end

  def exportCvs
    @list = Adprodstatic.queryAdvStatics(current_member.id,params)
    csv_string = CSV.generate  do |csv|
      csv << createExportMean(params[:bill_type],@list,csv)
    end
    csv_string="\uFEFF#{csv_string}"
    send_data csv_string,
              :type=>"text/csv;charset=iso-8859-1;header=present",
              :disposition =>"attachment; filename=#{(Time.now).strftime("%Y%m%d%H%M%S%s")}"
  end

  private

  def createExportMean(bill_type,list,csv)
    if bill_type.blank?
      csv << ["日期/时间","成本","有效展示","每千次展示成本"]
      list.each do |u|
        thousand_cost = 0
        thousand_cost=format("%.2f",(u.cost/u.displaynum)*1000).to_f if u.displaynum>0
        csv << [u.timed,u.cost,u.displaynum,thousand_cost]
      end
    elsif bill_type=='cpc'
      csv << ["日期/时间","成本","有效展示","点击次数","点击率","平均每次点击成本","每千次展示成本"]
      list.each do |u|
        click_rate=0
        click_rate=format("%.2f",(u.clickNum/u.displaynum)*100) if u.displaynum>0
        click_cost=0
        click_cost=format("%.2f",(u.cost/u.clickNum)).to_f if u.clickNum>0
        thousand_cost = 0
        thousand_cost=format("%.2f",(u.cost/u.displaynum)*1000).to_f if u.displaynum>0
        csv << [u.timed,u.cost,u.displaynum,u.clickNum,click_rate<<"%",click_cost,thousand_cost]
      end
    elsif bill_type=='cpm'
      csv << ["日期/时间","成本","有效展示","点击次数","点击率","每千次展示成本"]
      list.each do |u|
        click_rate=0
        click_rate=format("%.2f",(u.clickNum/u.displaynum)*100).to_f if u.displaynum>0
        thousand_cost = 0
        thousand_cost=format("%.2f",(u.cost/u.displaynum)*1000).to_f if u.displaynum>0
        csv << [u.timed,u.cost,u.displaynum,u.clickNum,click_rate<<"%",thousand_cost]
      end
    elsif bill_type=='ocpc'
      csv << ["日期/时间","成本","有效展示","点击次数","点击率","平均每次点击成本","每千次展示成本"]
      list.each do |u|
        click_rate=0
        click_rate=format("%.2f",(u.clickNum/u.displaynum)*100).to_f if u.displaynum>0
        click_cost=0
        click_cost=format("%.2f",(u.cost/u.clickNum)).to_f if u.clickNum>0
        thousand_cost = 0
        thousand_cost=format("%.2f",(u.cost/u.displaynum)*1000).to_f if u.displaynum>0
        csv << [u.timed,u.cost,u.displaynum,u.clickNum,click_rate<<"%",click_cost,thousand_cost]
      end
    elsif bill_type=='cpd'
      csv << ["日期/时间","成本","有效展示","下载次数","下载率","平均每次下载成本"]
      list.each do |u|
        download_rate=0
        download_rate=format("%.2f",(u.download_count/u.displaynum)*100).to_f if u.displaynum>0
        download_cost=0
        download_cost=format("%.2f",(u.cost/u.download_count)).to_f if u.download_count>0
        csv << [u.timed,u.cost,u.displaynum,u.download_count,download_rate<<"%",download_cost]
      end
    else
      csv << ["日期/时间","成本","有效展示","安装次数","安装率","平均每次安装成本"]
      list.each do |u|
        install_rate=0
        install_rate=format("%.2f",(u.install_count/u.displaynum)*100).to_f if u.displaynum>0
        install_cost=0
        install_cost=format("%.2f",(u.cost/u.install_count)).to_f if u.install_count>0
        csv << [u.timed,u.cost,u.displaynum,u.install_count,install_rate<<"%",install_cost]
      end
    end
    return csv
  end

end
