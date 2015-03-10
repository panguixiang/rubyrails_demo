require 'spec_helper'

describe Member::AppIstController do

  describe "GET 'appList'" do
    it "returns http success" do
      get 'appList'
      response.should be_success
    end
  end

end
