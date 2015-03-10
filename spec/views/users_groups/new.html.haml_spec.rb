require 'spec_helper'

describe "users_groups/new" do
  before(:each) do
    assign(:users_group, stub_model(UsersGroup,
      :name => "MyString",
      :group_access => 1,
      :group_id => 1,
      :notification_level => 1
    ).as_new_record)
  end

  it "renders new users_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_groups_path, "post" do
      assert_select "input#users_group_name[name=?]", "users_group[name]"
      assert_select "input#users_group_group_access[name=?]", "users_group[group_access]"
      assert_select "input#users_group_group_id[name=?]", "users_group[group_id]"
      assert_select "input#users_group_notification_level[name=?]", "users_group[notification_level]"
    end
  end
end
