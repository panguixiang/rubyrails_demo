require 'spec_helper'

describe "namespaces/show" do
  before(:each) do
    @namespace = assign(:namespace, stub_model(Namespace,
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
