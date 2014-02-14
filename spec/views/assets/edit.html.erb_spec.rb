require 'spec_helper'

describe "assets/edit" do
  before(:each) do
    @asset = assign(:asset, stub_model(Asset,
      :assetName => "MyString",
      :community => "MyString",
      :shortDescription => "MyString",
      :version => "MyString",
      :state => "MyString"
    ))
  end

  it "renders the edit asset form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", asset_path(@asset), "post" do
      assert_select "input#asset_assetName[name=?]", "asset[assetName]"
      assert_select "input#asset_community[name=?]", "asset[community]"
      assert_select "input#asset_shortDescription[name=?]", "asset[shortDescription]"
      assert_select "input#asset_version[name=?]", "asset[version]"
      assert_select "input#asset_state[name=?]", "asset[state]"
    end
  end
end
