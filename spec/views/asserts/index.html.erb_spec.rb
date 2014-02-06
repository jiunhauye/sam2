require 'spec_helper'

describe "asserts/index" do
  before(:each) do
    assign(:asserts, [
      stub_model(Assert,
        :assertName => "Assert Name",
        :community => "Community"
      ),
      stub_model(Assert,
        :assertName => "Assert Name",
        :community => "Community"
      )
    ])
  end

  it "renders a list of asserts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Assert Name".to_s, :count => 2
    assert_select "tr>td", :text => "Community".to_s, :count => 2
  end
end
