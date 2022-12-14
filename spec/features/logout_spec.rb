require 'rails_helper'

describe "As a logged in user" do
  describe "When I visit the landing page" do
    before(:each) do
      @user = User.create(name: 'User One', email: 'email@example.com', password: 'password123')

      visit "/"

      click_link "Log In"

      fill_in :email, with:'email@example.com'
      fill_in :password, with: 'password123'
      click_button 'Log In'
      click_link 'Home'
    end
    it "I no longer see a link to Log In or Create an Account" do
      expect(page).to_not have_button("Create New User")
      expect(page).to_not have_link("Log In")
    end

    it "But I see a link to Log Out." do
      expect(page).to have_link("Logout")
    end


    describe "When I click the link to Log Out" do
      before(:each) do
        click_link("Logout")
      end
      it "I'm taken to the landing page" do
        expect(current_path).to eq("/")
      end

      it "And I can see that the Log Out link has changed back to a Log In link" do
        expect(page).to have_link("Log In")
        expect(page).to have_button("Create New User")
        expect(page).to_not have_link("Logout")
      end
    end
  end
end
