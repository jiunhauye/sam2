require "spec_helper"

describe AssertsController do
  describe "routing" do

    it "routes to #index" do
      get("/asserts").should route_to("asserts#index")
    end

    it "routes to #new" do
      get("/asserts/new").should route_to("asserts#new")
    end

    it "routes to #show" do
      get("/asserts/1").should route_to("asserts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/asserts/1/edit").should route_to("asserts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/asserts").should route_to("asserts#create")
    end

    it "routes to #update" do
      put("/asserts/1").should route_to("asserts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/asserts/1").should route_to("asserts#destroy", :id => "1")
    end

  end
end
