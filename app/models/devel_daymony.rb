class DevelDaymony < ActiveRecord::Base
  attr_accessible :memberId,:cum_revenue,:unincome,:confirincome,:waitcash,:cancash,:alreadcash,:rewardcash,:automatic
  def self.develDayMoney(memberId)
    first(:conditions => ["memberId = ?",memberId])
  end

  def self.deverMonyAndInfo(memberId)
    sql = "select b.*,a.accountype,c.bankaddr,c.banknum,c.cardname,c.cardnum,c.cardtype,c.status from developer_infos as a"
    sql<<" left join devel_daymonies b on a.memberId=b.memberId "
    sql<<"left join developer_teams c on a.memberId=c.memberId where a.memberId=? and c.isleader=?"
    DeveloperInfo.find_by_sql([sql,memberId,1])
  end


  def self.setAutoMatic memberId
    auto =  find_by_memberId memberId
    if auto.automatic==1
      update(auto.id, :automatic => 2)
      return "2"
    elsif auto.automatic==2
      update(auto.id, :automatic => 1)
      return "1"
    end
  end

end
