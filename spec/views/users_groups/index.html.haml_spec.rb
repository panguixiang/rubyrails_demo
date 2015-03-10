require 'spec_helper'

describe "users_groups/index" do
  before(:each) do
    assign(:users_groups, [
      stub_model(UsersGroup,
        :name => "Name",
        :group_access => 1,
        :group_id => 2,
        :notification_level => 3
      ),
      stub_model(UsersGroup,
        :name => "Name",
        :group_access => 1,
        :group_id => 2,
        :notification_level => 3
      )
    ])
  end

  it "renders a list of users_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
