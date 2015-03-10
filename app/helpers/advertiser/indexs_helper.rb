module Advertiser::IndexsHelper

  def getRate(a,b)
    if b>0
      return ((a/b)*100).to_s<<" %"
    else
      return 0
    end
  end

end
