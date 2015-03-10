class Platform::NewsController < ApplicationController
  skip_filter :check_member_status
  def index
    @news_type=params[:news_type]
    if @news_type.nil?
      @news_type='1'
    end
    if @news_type=='4'
      @newList=Journal.queryJournal
    else
      @newList=News.queryNewsByType(@news_type)
    end
    @orationList=News.orationList(10)
    @hash = {:news_type=>@news_type,:newsList=>@newList,:orationList=>@orationList}
    render json:@hash.to_json
  end

  def getNews
    newsType=Integer(params[:newsType])
    offset=Integer(params[:offset])
    newList=News.queryNews(newsType,5,offset)
    offset = offset+5
    hash = Hash.new
    hash[:offset]=offset
    hash[:newsList] = newList
    information=params[:information]
    unless information.blank?
      informationList=News.queryNews(5,Integer(information),0)
      hash[:informationList] = informationList
    end
    respond_to do |format|
      format.json {render json: hash.to_json, :status => :ok}
    end
  end
end

