require 'spec_helper'

describe Member::AppAddController do

  describe "GET 'index1'" do
    it "returns http success" do
      get 'index1'
      response.should be_success
    end
  end

end
