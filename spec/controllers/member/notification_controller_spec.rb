require 'spec_helper'

describe Member::NotificationController do

  describe "GET 'note'" do
    it "returns http success" do
      get 'note'
      response.should be_success
    end
  end

end
