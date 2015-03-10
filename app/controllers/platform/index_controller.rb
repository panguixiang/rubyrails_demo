class Platform::IndexController < ApplicationController
  skip_filter :check_member_status

  def index
    if current_member.blank?
      cookies[:email]=nil
    end
    redirect_to '/html/index.html'
  end

  def carousel
    @pictureList = Picture.getPicListByType(1,4)
    @strongList = Picture.getPicListByType(2,2)
    @developPicList = Picture.getPicListByType(3,4)
    @partnerList = Picture.getPicListByType(4,60)
    @mediaList =  Picture.getPicListByType(5,60)
    render json: {'pictureList'=>@pictureList,'strongList'=>@strongList,'developPicList'=>@developPicList,'partnerList'=>@partnerList,'mediaList'=>@mediaList}
  end


end
