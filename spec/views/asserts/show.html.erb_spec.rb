require 'spec_helper'

describe "asserts/show" do
  before(:each) do
    @assert = assign(:assert, stub_model(Assert,
      :assertName => "Assert Name",
      :community => "Community"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Assert Name/)
    rendered.should match(/Community/)
  end
end
