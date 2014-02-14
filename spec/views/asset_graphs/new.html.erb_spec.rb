require 'spec_helper'

describe "asset_graphs/new" do
  before(:each) do
    assign(:asset_graph, stub_model(AssetGraph,
      :graph => "MyText",
      :file => ""
    ).as_new_record)
  end

  it "renders new asset_graph form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", asset_graphs_path, "post" do
      assert_select "textarea#asset_graph_graph[name=?]", "asset_graph[graph]"
      assert_select "input#asset_graph_file[name=?]", "asset_graph[file]"
    end
  end
end
