require 'rails_helper'

RSpec.describe 'Landing Page' do
    before :each do
        user1 = User.create(name: "User One", email: "user1@test.com", password: 'password123')
        user2 = User.create(name: "User Two", email: "user2@test.com", password: 'password123')
        visit '/'
    end

    it 'has a header' do
        expect(page).to have_content('Viewing Party Lite')
    end

    it 'has links/buttons that link to correct pages' do
        click_button "Create New User"

        expect(current_path).to eq(register_path)

        visit '/'

        click_link "Home"
        expect(current_path).to eq(root_path)
    end

    xit 'lists out existing users' do
        user1 = User.create(name: "User One", email: "user1@test.com", password: 'password123')
        user2 = User.create(name: "User Two", email: "user2@test.com", password: 'password123')

        expect(page).to have_content('Existing Users:')

        within('.existing-users') do
            expect(page).to have_content(user1.email)
            expect(page).to have_content(user2.email)
        end

    end

    describe 'As a visitor' do
      it "I do not see the section of the page that lists existing users" do
        expect(page).to_not have_content('Existing Users:')
      end
    end

    describe 'As a registered user' do
      describe 'When I visit the landing page' do
        it "The list of existing users is no longer a link to their show pages
          But just a list of email addresses" do
          user1 = User.create(name: "User One", email: "user1@test.com", password: 'password123')
          user2 = User.create(name: "User Two", email: "user2@test.com", password: 'password123')
          click_link "Log In"

          fill_in :email, with:'user2@test.com'
          fill_in :password, with: 'password123'
          click_button 'Log In'
          click_link 'Home'

          expect(page).to have_content('Existing Users:')

          within('.existing-users') do
              expect(page).to have_content(user1.email)
              expect(page).to have_content(user2.email)
          end
        end
      end
    end
end
