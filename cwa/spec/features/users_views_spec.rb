require 'rails_helper'

describe "Users pages" do
  it "should not be visible when not signed in" do
    visit users_path
    expect(page).to have_content 'You must be signed in to view this page!'
    expect(page).to have_content 'Sign in'
  end

  describe "should allow signing up at the signup path" do
    it "which should be visible" do
      visit signup_path
      expect(page).to have_content 'New User'
      expect(page).to have_content 'Username'
      expect(page).to have_content 'Password confirmation'
    end
    it "and when signed up with good credentials, a user is added to the system" do
      visit signup_path
      fill_in('user_username', with:'Brian')
      fill_in('user_password', with:'Secret55')
      fill_in('user_password_confirmation', with:'Secret55')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end
end

describe "User" do
    let!(:user){FactoryGirl.create :user}

  describe "who has signed up" do
    it "can signin with right credentials" do
      visit signin_path
      fill_in('username', with:'Veera')
      fill_in('password', with:'salasana1')
      click_button('Log in')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Veera'
    end

    it "is redirected back to signin form if wrong credentials given" do
      visit signin_path
      fill_in('username', with:'Veera')
      fill_in('password', with:'wrong')
      click_button('Log in')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
    it "may not edit another user's profile" do
      user2 = FactoryGirl.create :user, username:"Matti"
      visit signin_path
      fill_in('username', with:'Veera')
      fill_in('password', with:'salasana1')
      click_button('Log in')

      visit users_path
      expect(page).to have_content 'Veera Show Edit'
      expect(page).to have_content 'Matti Show New User'

      # The link to edit users is not displayed on other users' pages.
      # To test that editing other users cannot be done, you should uncomment the relevant lines and comment out some in users/show.html.erb
      #visit "/users/2"
      #click_link "Edit"
      #expect(page).to have_content 'You may not edit other users'
    end
    it "may edit their own profile" do
      visit signin_path
      fill_in('username', with:'Veera')
      fill_in('password', with:'salasana1')
      click_button('Log in')

      visit users_path
      expect(page).to have_content 'Veera Show Edit'

      click_link "Edit"

      fill_in('user_password', with:'salasana2')
      fill_in('user_password_confirmation', with:'salasana2')
      click_button('Update User')

      expect(page).to have_content 'User was successfully updated.'

    end
    it "may destroy their own profile" do
      user2 = FactoryGirl.create :user, username:"Matti"
      expect(User.count).to eq(2)
      visit signin_path
      fill_in('username', with:'Veera')
      fill_in('password', with:'salasana1')
      click_button('Log in')

      expect(page).to have_content 'Veera'
      expect(page).to have_content 'Edit'
      expect(page).to have_content 'Destroy'

      delete_link = find_link 'Destroy'
      expect(delete_link['data-confirm']).to eq 'Are you sure?'

      click_link "Destroy"
      expect(page).to have_content 'You must be signed in to view this page!'
      expect(User.count).to eq(1)

    end
  end
end