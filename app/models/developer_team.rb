class DeveloperTeam < ActiveRecord::Base
  @isCheckBank=0
  @isCheckUrl=0
  attr_accessible :memberId,:cardtype,:cardname,:cardnum,:bankaddr,:banknum,:sideurl,:outsideurl
  validates_presence_of :memberId, message:  "memberId不能为空!"
  validates_presence_of :cardtype, message:  "请选择证件类型!"
  validates_presence_of :cardname, message:  "请输入证件姓名!"
  validates_presence_of :cardnum,  message:  "请输入证件号码!"
  validates_presence_of :bankaddr,message:  "请输入开户行全称!",if: :isCheckBanks
  validates_presence_of :banknum, message: "请输入银行账号!",if: :isCheckBanks
  validates_presence_of :sideurl, message: "请上传正确的证件正面!", if: :isCheckUrls
  validates_presence_of :outsideurl,message: "请上传正确的证件反面!", if: :isCardID
  validates_length_of :bankaddr,:maximum => 80,message: "请输入80个字符以内的开户行全称!",unless: :bankaddr_black
  validates_length_of :banknum,:maximum => 40,message: "请输入40个字符以内的银行账号!",unless: :banknum_black
  validates_length_of :sideurl,:maximum => 100,message: "您上传的证件正面照片名称过长!",unless: :sideUrl_black
  validates_length_of :outsideurl,:maximum => 100,message: "您上传的证件反面照片名称过长!",unless: :outSideUrl_black
  validates_length_of :cardname,:maximum => 30,message: "您输入的证件姓名请保持在30个字符内!",unless: :cardname_black
  validates_length_of :cardnum,:maximum => 20,message: "您输入的证件号码请保持在20个字符内!",unless: :cardnum_black


  def setIsCheckBank=(value)
    @isCheckBank = value
  end

  def getIsCheckBank()
    @isCheckBank
  end

  def setIsCheckUrl=(value)
    @isCheckUrl = value
  end

  def getIsCheckUrl()
    @isCheckUrl
  end

  def self.getDevelopTeamByMemberIdAndLeader(memberId, isLeader)
    DeveloperTeam.find_by_memberId_and_isleader(memberId,isLeader)
  end

  def updateTeam(team)
    DeveloperTeam.update(team.id,:sideurl=>team.sideurl,:outsideurl=>team.sideurl,
                         :bankaddr=>team.bankaddr,:banknum=>team.banknum)
  end

  def self.selectFieldsByMemberIdAndLeader(memberId, isLeader)
    DeveloperTeam.select(:cardtype,:cardname,:cardnum,:status)
      .where("memberId=? and isleader=?", memberId, isLeader).order(created_at: :asc)
  end

  def insertTeam params
    self.isleader=2
    self.status=1
    self.rate=0.00
    side = params[:developer_team][:sidePic]
    sidePath = UploadFile.uploadImage side
    self.sideurl=sidePath
    if self.cardtype=="ID"
      out = params[:developer_team][:outPic]
      outPath = UploadFile.uploadImage out
      self.outsideurl=outPath
    end
    self.setIsCheckUrl=(0)
    return self.save
  end



  private

  def isCardID
    if self.cardtype=='ID' and self.getIsCheckUrl==0
      return true
    else
      return false
    end
  end
  def isCheckBanks
    self.getIsCheckBank==1
  end
  def isCheckUrls
    self.getIsCheckUrl==0
  end
  def bankaddr_black
    !self.bankaddr.blank?
  end
  def banknum_black
    !self.banknum.blank?
  end
  def sideUrl_black
    !self.sideurl.blank?
  end
  def outSideUrl_black
    !self.outsideurl.blank?
  end
  def cardname_black
    !self.cardname.blank?
  end
  def cardnum_black
    !self.cardnum.blank?
  end
end
