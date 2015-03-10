require 'spec_helper'

describe "appfilters/show" do
  before(:each) do
    @appfilter = assign(:appfilter, stub_model(Appfilter))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
