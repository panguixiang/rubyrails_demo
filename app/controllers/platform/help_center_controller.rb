class Platform::HelpCenterController < ApplicationController
  skip_filter :check_member_status

  def index
    cate1 = params[:cate1]
    if cate1.nil?
      cate1='1'
    end
    @helpList = HelpCenter.queryCate(cate1)
    @hash = {'cate1'=>cate1,'helplist'=>@helpList}
    render json:@hash.to_json
  end

end
