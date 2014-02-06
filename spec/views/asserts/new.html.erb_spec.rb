require 'spec_helper'

describe "asserts/new" do
  before(:each) do
    assign(:assert, stub_model(Assert,
      :assertName => "MyString",
      :community => "MyString"
    ).as_new_record)
  end

  it "renders new assert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", asserts_path, "post" do
      assert_select "input#assert_assertName[name=?]", "assert[assertName]"
      assert_select "input#assert_community[name=?]", "assert[community]"
    end
  end
end
