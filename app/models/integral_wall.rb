require 'mime/types'
class IntegralWall < ActiveRecord::Base
  attr_accessible :id, :memberId, :app_name, :platform, :app_type, :source, :package_type, :package_name,:version_code, :adver_type,
                  :checkstatus,:status,:active_income, :currency_name, :exchange_rate, :ishow_balance
  validate :memberId, presence: true
  validate :platform, presence: true
  validate :publisherid, presence: true
  validate :adver_type, presence: true, if: :isplatform
  validates_presence_of :app_name,message: "请填写应用名称"
  validates_length_of :app_name, maximum: 20,message: "应用名称不能大于20个字符（一个中文字占两个字符）"
  validates_presence_of :app_type,message: "请选择应用类别"
  validates_presence_of :source,message: "请填写链接或上传安装包", if: :souceBlank
  validates_presence_of :package_type,message: "请填写链接或上传安装包",if: :isplatform
  validates_presence_of :currency_name,message: "请填写货币名称"
  validate :validate_rate

  protected

  def validate_rate
    return errors.add(:exchange_rate, "请输入整数b且不能小于1大于200000") if self.exchange_rate.blank?
    return errors.add(:exchange_rate, "请输入整数c且不能小于1大于200000") if self.exchange_rate<1 || self.exchange_rate > 200000
  end



  private

  def isplatform
    self.platform=='ios'
  end
  def souceBlank
    puts "-----#{self.source}---------";
    self.source.blank?
  end
end
