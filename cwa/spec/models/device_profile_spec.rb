require 'rails_helper'

RSpec.describe DeviceProfile, type: :model do

  it "when creating a new device all attributes are set correctly" do
    dp = FactoryGirl.create(:device_profile)
    expect(dp.profile_name).to eq("abcd")
    expect(dp.sw_version).to eq("efg")
    expect(dp.hw_version).to eq("123")
    expect(dp.device_type).to eq("qwerty")
    expect(dp.info).to eq("info here")
    expect(dp.name).to eq("yesyes")
    expect(dp.data_transformer).to eq("bob")
  end
end
