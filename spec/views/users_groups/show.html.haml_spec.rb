require 'spec_helper'

describe "users_groups/show" do
  before(:each) do
    @users_group = assign(:users_group, stub_model(UsersGroup,
      :name => "Name",
      :group_access => 1,
      :group_id => 2,
      :notification_level => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
