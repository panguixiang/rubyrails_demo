class HelpCenter < ActiveRecord::Base

  def self.queryCate(cate1='1')
    if cate1=='1'
      return HelpCenter.where("cate1 = ?", Integer(cate1)).limit(1)
    else
      return HelpCenter.where("cate1 = ?", Integer(cate1))
    end
  end
end
