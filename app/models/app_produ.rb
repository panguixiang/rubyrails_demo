require 'where'
class AppProdu < ActiveRecord::Base
  @isCheckPackage=0
  has_many :advertisings
  has_many :appfilters
  attr_accessible :app_content, :isposition, :app_type, :keyword, :app_name, :platform,
                  :id,:memberId,:auto_reflush,:auto_value,:version_code,:package_name
  validates_presence_of :platform,message:  "请选择应用平台!"
  validates_presence_of :app_name,message:  "请输入应用名称!"
  validates_presence_of :keyword,message:  "请输入关键字!"
  validates_presence_of :app_type,message:  "请选择应用类型!"
  validates :app_name, uniqueness: {message: "您输入的广告位名称已被使用！" }
  validates_presence_of :package_name,message:  "应用包名称不能为空!", if: :isCheckApk
  validates_presence_of :version_code,message:  "应用包版本号不能为空!", if: :isCheckApk

  def setIsCheckPackage=(value)
    @isCheckPackage = value
  end

  def getIsCheckPackage()
    @isCheckPackage
  end

  def self.get_search_query_string(status,memberId,appName,platform)
    where = Where.new
    where.and('app_produs.memberId = ?', memberId) unless memberId.blank?
    where.and('app_produs.status = ?', status) unless status.blank?
    where.and('app_produs.platform = ?', platform) unless platform.blank?
    where.and('app_produs.app_name like ?', appName + '%') unless appName.blank?
    where.to_s
  end

  def self.queryAppProd(status,memberId,appName,platform,page)
    sql ="select a.id,a.app_name,a.status,sum(a.incoming) as incoming,sum(a.display_count) as display_count "
    sql<<"from ( SELECT app_produs.id,app_produs.app_name,app_produs.status,app_statics.incoming,app_statics.display_count "
    sql<<"FROM app_produs left join app_statics on app_produs.id=app_statics.app_id where"
    sql<<get_search_query_string(status,memberId,appName,platform)
    sql<<" order by app_produs.created_at desc )a "
    sql<<" group by a.id limit ? offset ? "
    AppProdu.find_by_sql([sql,page.getPageLimit,page.getOffSet])
  end

  def self.findMemberIdGroupByStatus memberId
    AppProdu.select("status,count(status) as num ").where("memberId=?", memberId).group("status")
  end

  def self.queryAppProdCount(status,memberId,appName,platform)
    sql = get_search_query_string(status,memberId,appName,platform)
    AppProdu.find(:all,:conditions =>sql).count
  end

  def self.getAppByIdAndMemberId(id,memberId)
    select("id,app_name,publisherid,platform,app_type,status,keyword,app_content").where("id=? and memberId=?",id,memberId)
  end

  def self.deleteAppById(id)
    begin
      transaction do
        AppProdu.delete id
        Appfilter.where(app_produ_id: id).delete_all
        Advertising.where(app_produ_id: id).delete_all
      end
    rescue Exception => e
      return false
    end
    return true
  end

  def self.getAppIdAndNameList(memberId)
      select(:id,:app_name).where("memberId=?", memberId)
  end


  private

  def isCheckApk
    self.getIsCheckPackage==1
  end

end

