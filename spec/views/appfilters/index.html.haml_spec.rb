require 'spec_helper'

describe "appfilters/index" do
  before(:each) do
    assign(:appfilters, [
      stub_model(Appfilter),
      stub_model(Appfilter)
    ])
  end

  it "renders a list of appfilters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
