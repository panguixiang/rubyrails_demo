require "spec_helper"

describe UsersGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/users_groups").should route_to("users_groups#index")
    end

    it "routes to #new" do
      get("/users_groups/new").should route_to("users_groups#new")
    end

    it "routes to #show" do
      get("/users_groups/1").should route_to("users_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/users_groups/1/edit").should route_to("users_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/users_groups").should route_to("users_groups#create")
    end

    it "routes to #update" do
      put("/users_groups/1").should route_to("users_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/users_groups/1").should route_to("users_groups#destroy", :id => "1")
    end

  end
end
