require 'spec_helper'

describe "appfilters/new" do
  before(:each) do
    assign(:appfilter, stub_model(Appfilter).as_new_record)
  end

  it "renders new appfilter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", appfilters_path, "post" do
    end
  end
end
