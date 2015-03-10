require 'spec_helper'

describe "namespaces/new" do
  before(:each) do
    assign(:namespace, stub_model(Namespace,
      :name => "MyString",
      :avatar => "MyString",
      :path => 1,
      :owner_id => 1,
      :type => "",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new namespace form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", namespaces_path, "post" do
      assert_select "input#namespace_name[name=?]", "namespace[name]"
      assert_select "input#namespace_avatar[name=?]", "namespace[avatar]"
      assert_select "input#namespace_path[name=?]", "namespace[path]"
      assert_select "input#namespace_owner_id[name=?]", "namespace[owner_id]"
      assert_select "input#namespace_type[name=?]", "namespace[type]"
      assert_select "input#namespace_description[name=?]", "namespace[description]"
    end
  end
end
