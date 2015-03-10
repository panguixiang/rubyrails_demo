require 'spec_helper'

describe "groups/show" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :name => "Name",
      :avatar => "Avatar",
      :path => 1,
      :owner_id => 2,
      :type => "Type",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Avatar/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Type/)
    rendered.should match(/Description/)
  end
end
