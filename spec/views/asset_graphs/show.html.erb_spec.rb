require 'spec_helper'

describe "asset_graphs/show" do
  before(:each) do
    @asset_graph = assign(:asset_graph, stub_model(AssetGraph,
      :graph => "MyText",
      :file => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
