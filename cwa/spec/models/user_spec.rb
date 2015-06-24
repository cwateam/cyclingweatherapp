require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user)}
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "can have devices" do
      device = FactoryGirl.create(:device)
      user.devices << device

      expect(user.devices.count).to eq(1)
    end
  end
end
