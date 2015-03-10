require 'spec_helper'

describe "groups/new" do
  before(:each) do
    assign(:group, stub_model(Group,
      :name => "MyString",
      :avatar => "MyString",
      :path => 1,
      :owner_id => 1,
      :type => "",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", groups_path, "post" do
      assert_select "input#group_name[name=?]", "group[name]"
      assert_select "input#group_avatar[name=?]", "group[avatar]"
      assert_select "input#group_path[name=?]", "group[path]"
      assert_select "input#group_owner_id[name=?]", "group[owner_id]"
      assert_select "input#group_type[name=?]", "group[type]"
      assert_select "input#group_description[name=?]", "group[description]"
    end
  end
end
