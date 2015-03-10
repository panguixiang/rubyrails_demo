require 'spec_helper'

describe "appfilters/edit" do
  before(:each) do
    @appfilter = assign(:appfilter, stub_model(Appfilter))
  end

  it "renders the edit appfilter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", appfilter_path(@appfilter), "post" do
    end
  end
end
