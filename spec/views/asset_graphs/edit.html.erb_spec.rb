require 'spec_helper'

describe "asset_graphs/edit" do
  before(:each) do
    @asset_graph = assign(:asset_graph, stub_model(AssetGraph,
      :graph => "MyText",
      :file => ""
    ))
  end

  it "renders the edit asset_graph form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", asset_graph_path(@asset_graph), "post" do
      assert_select "textarea#asset_graph_graph[name=?]", "asset_graph[graph]"
      assert_select "input#asset_graph_file[name=?]", "asset_graph[file]"
    end
  end
end
