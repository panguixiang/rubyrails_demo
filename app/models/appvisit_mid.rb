class AppvisitMid < ActiveRecord::Base
  attr_accessible :memberId,:cpc_display,:cpc_click,:cpc_rate,:cpm_display,:now_cost,:created_at
  def self.query7DayMemberVistLog(memberId,size)
    AppvisitMid.select(:now_cost,:created_at).where("memberId = ?", memberId).order(created_at: :desc).limit(size)
  end
  def self.query3DayMemberVistLog(memberId,size)
    AppvisitMid.where("memberId = ?", memberId).order(created_at: :desc).limit(size)
  end
end
