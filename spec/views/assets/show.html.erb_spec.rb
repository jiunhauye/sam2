require 'spec_helper'

describe "assets/show" do
  before(:each) do
    @asset = assign(:asset, stub_model(Asset,
      :assetName => "Asset Name",
      :community => "Community",
      :shortDescription => "Short Description",
      :version => "Version",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Asset Name/)
    rendered.should match(/Community/)
    rendered.should match(/Short Description/)
    rendered.should match(/Version/)
    rendered.should match(/State/)
  end
end
