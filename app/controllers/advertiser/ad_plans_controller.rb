class Advertiser::AdPlansController < FatherController
  before_filter :authenticate_member!
  def index
    if params[:bill_type].blank?
      bill_type='cpc'
    else
      bill_type=params[:bill_type]
    end
    pageNum = params[:pageNum]
    @page = Page.new(pageNum)
    @list=Adprodstatic.queryFinances(current_member.id, bill_type, params[:planName],@page)
    @page.pageCount(Adprodstatic.queryAdplanCount(current_member.id,bill_type,params[:planName]))
  end
end
