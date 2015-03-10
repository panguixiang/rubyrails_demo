require 'where'
class TakeMoney < ActiveRecord::Base
  attr_accessible :id,:memberId,:status,:take_money,:success_money,:tn

  def self.queryGroupByMemberId memberId,unstatus
    sql = "select sum(sd.take_money) as nowTakeMoney from "
    sql<<" (select DATE_FORMAT(created_at,'%Y-%m') as month,take_money from take_moneys "
	  sql<<" where memberId=? and status != ? ) sd group by sd.month order by sd.month limit 1 "
    list = TakeMoney.find_by_sql([sql,memberId,unstatus])
    if list.blank?
      return 0.00
    else
      return list[0].nowTakeMoney
    end
  end

  def self.takedMonthLogs(status,memberId,created_at)
    TakeMoney.select(:status,:take_money,:success_money,:tn,:created_at).where(" memberId=? and status!=? and DATE_FORMAT(created_at,'%Y-%m')=? ",memberId,status,created_at)
  end

  def self.caseMoney(memberId, amount)
    deveAllMoney = DevelDaymony.find_by_memberId(memberId)
    takeMoney = TakeMoney.new
    takeMoney.memberId=memberId
    takeMoney.status=1
    takeMoney.tn=ProUtils.createTimeUUID(memberId.to_s)
    begin
      amount=amount.gsub(".","")
      unless amount.to_i.to_s==amount
        return "请输入正确格式的提现金额！大于100RMB，小于等于当前可提现总金额！"
      end
      amount = amount.to_f
      if amount<100
        return "请输入正确格式的提现金额！大于100RMB，小于等于当前可提现总金额！"
      end
      deveAllMoney.waitcash=deveAllMoney.waitcash+amount
      deveAllMoney.cancash=deveAllMoney.cancash-amount
      takeMoney.take_money=amount
      transaction do
        deveAllMoney.save!
        takeMoney.save!
      end
    rescue Exception => e
      return "系统异常，提现失败！"
    end
    return ""
  end


  def self.get_search_query_string(memberId,startDate,endDate)
    where = Where.new
    where.and('memberId = ?', memberId)
    where.and('created_at >= ?', startDate) unless startDate.blank?
    where.and('created_at < ?', endDate) unless endDate.blank?
    where.to_s
  end

  def self.queryTakeMoneys(memberId,startDate,endDate)
    sql = get_search_query_string(memberId,startDate,endDate)
    find(:all,:conditions =>sql,:order=> "created_at ASC")
  end


end
