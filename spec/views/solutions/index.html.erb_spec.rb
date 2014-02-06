require 'spec_helper'

describe "solutions/index" do
  before(:each) do
    assign(:solutions, [
      stub_model(Solution,
        :solutionLabel => "Solution Label"
      ),
      stub_model(Solution,
        :solutionLabel => "Solution Label"
      )
    ])
  end

  it "renders a list of solutions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Solution Label".to_s, :count => 2
  end
end
