require "spec_helper"

describe AssetGraphsController do
  describe "routing" do

    it "routes to #index" do
      get("/asset_graphs").should route_to("asset_graphs#index")
    end

    it "routes to #new" do
      get("/asset_graphs/new").should route_to("asset_graphs#new")
    end

    it "routes to #show" do
      get("/asset_graphs/1").should route_to("asset_graphs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/asset_graphs/1/edit").should route_to("asset_graphs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/asset_graphs").should route_to("asset_graphs#create")
    end

    it "routes to #update" do
      put("/asset_graphs/1").should route_to("asset_graphs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/asset_graphs/1").should route_to("asset_graphs#destroy", :id => "1")
    end

  end
end
