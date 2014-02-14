require 'spec_helper'

describe "asset_graphs/index" do
  before(:each) do
    assign(:asset_graphs, [
      stub_model(AssetGraph,
        :graph => "MyText",
        :file => ""
      ),
      stub_model(AssetGraph,
        :graph => "MyText",
        :file => ""
      )
    ])
  end

  it "renders a list of asset_graphs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
