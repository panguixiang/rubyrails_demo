class DeveloperInfo < ActiveRecord::Base
  attr_accessible :memberId,:accountype,:company,:contact,:qq,:msn,:mobile,:wechat,:telphone,:address
  validate :memberId, presence: true, uniqueness: true
  validate :accountype,presence: true
  validates_presence_of :company,message: "请输入公司名称", if: :isAccountypeEq2
  validates_presence_of :contact,message: "请输入联系人名称", if: :isAccountypeEq2
  validates_length_of :mobile,maximum:15,message: "请输入15个字符以内的手机号码"
  validates_length_of :msn, maximum: 55,message: "请输入40个字符以内的MSN账号!", unless: :msn_black
  validates_length_of :wechat, maximum: 55,message: "请输入40个字符以内的微信账号!", unless: :wechat_black
  validates_length_of :telphone, maximum: 18,message: "请输入18个字符以内的电话!", unless: :telphone_black
  validates_length_of :address, maximum: 120,message: "请输入100个字符以内的地址!", unless: :address_black
  validates_format_of :mobile,:message=>"请输入正确格式的手机号码",:with => /\d{11}/
  validates_format_of :qq,message:"请输入正确格式的qq号码",:with => /\A\d{4,12}\z/,if: :isAccountypeEq1

  def self.insertInfo(info,mType,cardtype,cardname,cardnum)
    deverMoney = DevelDaymony.new
    deverMoney.memberId=info.memberId
    if info.accountype==1
      info.company=''
      info.contact=''
      team = DeveloperTeam.new
      team.setIsCheckUrl =1
      team.sideurl=""
      team.outsideurl=""
      team.isleader=1
      team.status=1
      team.memberId=info.memberId
      team.cardname=cardname
      team.cardtype=cardtype
      team.cardnum=cardnum
      team.rate=100
    end
    begin
      transaction do
        deverMoney.save!
        if info.accountype==1
          team.save!
          info.save!
        else
          info.save!
        end
        member = Member.find info.memberId
        member.update_attributes!(:m_type=>mType,:status=>2)
      end
    rescue Exception => e
      return false;
    end
    return true
  end

  def self.insertAdverInfo(info,mType)
    adFinance = Adfinances.new
    adFinance.memberId=info.memberId
    adFinance.consumday=0.00
    adFinance.now_balance=0.00
    info.accountype=0
    info.company==' '
    begin
      transaction do
        info.save!
        adFinance.save!
        member = Member.find info.memberId
        member.update_attributes!(:m_type=>mType,:status=>3)
      end
    rescue Exception => e
      return false;
    end
    return true
  end

  def self.getDevelopInfoByMemberId memberId
    DeveloperInfo.find_by_memberId memberId
  end

  def self.updateInfo(params,info)

    if info.accountype==1
      info.qq=params[:developer_info][:qq]
    else
      info.contact=params[:developer_info][:contact]
    end
    info.msn = params[:developer_info][:msn]
    info.mobile = params[:developer_info][:mobile]
    info.wechat = params[:developer_info][:wechat]
    info.telphone = params[:developer_info][:telphone]
    info.address = params[:developer_info][:address]
    flag = info.save
    return flag
  end


  private
  def isAccountypeEq1
    self.accountype==1
  end
  def isAccountypeEq2
    self.accountype==2
  end
  def msn_black
    !self.msn.blank?
  end
  def wechat_black
    !self.wechat.blank?
  end
  def telphone_black
    !self.telphone.blank?
  end
  def address_black
    !self.address.blank?
  end
end
