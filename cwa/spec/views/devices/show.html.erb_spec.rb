require 'rails_helper'

RSpec.describe "devices/show", type: :view do
  before(:each) do
    @device = assign(:device, Device.create!(
      :device_id => "Device"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Device/)
  end
end
