require 'where'
class Appfilter < ActiveRecord::Base
  belongs_to :app_produ
  attr_accessible :id, :app_produ_id,:filter_type,:filter_content,:created_at,:updated_at

  def self.search_AppFilter(app_produ_id,filter_type)
    where = Where.new
    where.and('app_produ_id = ?', app_produ_id) unless app_produ_id.blank?
    where.and('filter_type = ?', filter_type) unless filter_type.blank?
    where.to_s
  end

  def self.saveOrUpdate appfilter
    if appfilter.filter_type==3 || appfilter.filter_type==4
      unless appfilter.blank?
        appfilter.filter_content=appfilter.filter_content.join(',')
      end
      updateAppfilter = find_by_app_produ_id_and_filter_type(appfilter.app_produ_id,appfilter.filter_type)
      unless updateAppfilter.nil?
        updateAppfilter.filter_content = appfilter.filter_content
        return updateAppfilter.save
      else
        return appfilter.save
       end
    else
      return appfilter.save
    end
  end
end
