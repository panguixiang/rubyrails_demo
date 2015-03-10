require 'spec_helper'

describe "namespaces/index" do
  before(:each) do
    assign(:namespaces, [
      stub_model(Namespace,
        :name => "Name",
        :avatar => "Avatar",
        :path => 1,
        :owner_id => 2,
        :type => "Type",
        :description => "Description"
      ),
      stub_model(Namespace,
        :name => "Name",
        :avatar => "Avatar",
        :path => 1,
        :owner_id => 2,
        :type => "Type",
        :description => "Description"
      )
    ])
  end

  it "renders a list of namespaces" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
