require 'rails_helper'

RSpec.describe "devices/index", type: :view do
  before(:each) do
    assign(:devices, [
      Device.create!(
        :device_id => "Device"
      ),
      Device.create!(
        :device_id => "Device"
      )
    ])
  end

  it "renders a list of devices" do
    render
    assert_select "tr>td", :text => "Device".to_s, :count => 2
  end
end
