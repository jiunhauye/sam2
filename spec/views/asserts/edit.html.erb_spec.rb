require 'spec_helper'

describe "asserts/edit" do
  before(:each) do
    @assert = assign(:assert, stub_model(Assert,
      :assertName => "MyString",
      :community => "MyString"
    ))
  end

  it "renders the edit assert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", assert_path(@assert), "post" do
      assert_select "input#assert_assertName[name=?]", "assert[assertName]"
      assert_select "input#assert_community[name=?]", "assert[community]"
    end
  end
end
