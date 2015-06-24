require 'rails_helper'

RSpec.describe Device, type: :model do
  let(:user){ FactoryGirl.create(:user)}
  let(:dp){ FactoryGirl.create(:device_profile)}

  it "has device_id set correctly" do
    device = Device.new device_id:"abcd"

    expect(device.device_id).to eq("abcd")
  end
  it "has device_profile_id set correctly" do
    device = Device.new device_profile_id:dp.id

    expect(device.device_profile_id).to eq(1)
    expect(device.device_profile).to eq(dp)
  end
  it "has user_id set correctly" do
    device = Device.new user_id:user.id

    expect(device.user_id).to eq(1)
    expect(device.user).to eq(user)
  end
end
