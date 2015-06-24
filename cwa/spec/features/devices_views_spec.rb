require 'rails_helper'

describe "Devices pages" do
  it "should not be visible when not signed in" do
    visit devices_path
    expect(page).to have_content 'You must be signed in to view this page!'
    expect(page).to have_content 'Sign in'
  end
end

describe "" do
  let!(:user) {FactoryGirl.create :user}
  let!(:dp){FactoryGirl.create :device_profile}
  let!(:device){FactoryGirl.create :device}

  it "Device page should not be visible when not signed in" do
    visit "/devices/1"
    expect(page).to have_content 'You must be signed in to view this page!'
    expect(page).to have_content 'Sign in'
  end

  describe "When a user is signed in," do
    before :each do
      visit signin_path
      fill_in('username', with:'Veera')
      fill_in('password', with:'salasana1')
      click_button('Log in')
    end

    it "devices can be viewed" do
      visit devices_path
      expect(page).to have_content 'Listing Devices'
      expect(page).to have_content 'laite yesyes Edit Destroy'

    end

    it "a device can be added" do
      visit devices_path
      click_link "New Device"

      fill_in('Device', with:'laite2')
      select('yesyes', from:'device[device_profile_id]')
      click_button('Create Device')

      expect(page).to have_content 'Device was successfully created.'
    end

    it "their own device can be edited" do
      visit devices_path
      click_link "Edit"

      fill_in('Device', with:'laite_uusi')
      select('yesyes', from:'device[device_profile_id]')
      click_button('Update Device')

      expect(page).to have_content 'Device was successfully updated.'
      expect(Device.first.device_id).to eq('laite_uusi')
    end
    it "a device cannot be edited if it belongs to another user" do
      FactoryGirl.create :user, username:"Matti"
      FactoryGirl.create :device, device_id:"laite2", user_id:2

      expect(User.count).to eq(2)
      expect(Device.count).to eq(2)

      visit devices_path
      expect(page).to have_content 'laite2 yesyes New Device'

      # The link to edit devices is not displayed on other users' device pages.
      # To test that editing other users' devices cannot be done, you should uncomment the relevant lines below and comment out some in views/devices/show.html.erb
      #visit "/devices/2"
      #click_link "Edit"
      #expect(page).to have_content 'You may not edit other users'
    end
    it "may be destroyed if it is the user's own device" do
      visit devices_path

      delete_link = find_link 'Destroy'
      expect(delete_link['data-confirm']).to eq 'Are you sure?'

      click_link "Destroy"
      expect(page).to have_content 'Device was successfully destroyed.'
      expect(Device.count).to eq(0)

    end
  end
end
