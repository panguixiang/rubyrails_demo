class Advertising < ActiveRecord::Base
  belongs_to :app_produ
  attr_accessible :id, :adver_name,:adver_type,:status,:innlinepid,
                  :iscreen,:isvideo,:ismute,:icon,:title,:content,:descrip,
                  :media,:app_produ_id
  validates_presence_of :adver_name,message: "请输入广告名称！"
  validates_presence_of :adver_type,message: "请选中广告类型！"
  validates_presence_of :innlinepid,message: "广告代码不能为空！"
  validates_presence_of :icon,message: "请选中广告类型", if: :isCheckScreen
  validates_presence_of :title,message: "请选中广告类型", if: :isCheckScreen
  validates_presence_of :app_produ_id
  # validates :adver_name, uniqueness: {message: "您输入的广告位名称已被使用！" }
  def self.sss(params)
    adver = Advertising.new
    adver.save!
    return adver
  end

  def self.searchAdver()
    app_produ_id=param(:app_produ_id)
    @advertising=Advertising.where("app_produ_id=?", app_produ_id)
  end



  private

  def isCheckScreen
    return true if self.adver_type==6
    return false
  end

end
