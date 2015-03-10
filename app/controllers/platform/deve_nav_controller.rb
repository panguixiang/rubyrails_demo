class Platform::DeveNavController < ApplicationController
  skip_filter :check_member_status

  def carousel
    @carsouLists = Carousel.queryCarouSels(1,2,3)
    render json: {'carsouList2'=>@carsouLists}
  end
end
