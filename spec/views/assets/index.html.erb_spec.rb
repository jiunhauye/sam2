require 'spec_helper'

describe "assets/index" do
  before(:each) do
    assign(:assets, [
      stub_model(Asset,
        :assetName => "Asset Name",
        :community => "Community",
        :shortDescription => "Short Description",
        :version => "Version",
        :state => "State"
      ),
      stub_model(Asset,
        :assetName => "Asset Name",
        :community => "Community",
        :shortDescription => "Short Description",
        :version => "Version",
        :state => "State"
      )
    ])
  end

  it "renders a list of assets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Asset Name".to_s, :count => 2
    assert_select "tr>td", :text => "Community".to_s, :count => 2
    assert_select "tr>td", :text => "Short Description".to_s, :count => 2
    assert_select "tr>td", :text => "Version".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
