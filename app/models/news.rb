class News < ActiveRecord::Base
  def self.queryNewsByType(newsType)
    where("news_type=?",Integer(newsType))
  end

  def self.queryNews(newsType,limit, offset)
    sql = "select id,title,introduction,comefrom,url,created_at  from news where news_type=? order by created_at limit ? offset ? "
    News.find_by_sql([sql,newsType,limit,offset])
  end


end
