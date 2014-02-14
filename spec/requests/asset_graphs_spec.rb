require 'spec_helper'

describe "AssetGraphs" do
  describe "GET /asset_graphs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get asset_graphs_path
      response.status.should be(200)
    end
  end
end
