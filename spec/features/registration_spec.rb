require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'

    find_field('Password').set('password12')
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end

  it 'does not create a user if email isnt unique' do
    User.create(name: 'User One', email: 'notunique@example.com', password: "password1")

    visit register_path

    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'

    find_field('Password').set('password12')
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")

  end

  describe "When I visit `/register`" do
      it "I see a form to fill in my name, email, password, and password confirmation" do
        visit register_path

        expect(page).to have_content("Password")
      end
    end
  describe 'When I fill in that form with my name, email, and matching passwords' do
    it "I am m taken to my dashboard page `/users/:id`" do
      visit register_path

      fill_in 'Name', with: 'Martin'
      fill_in 'Email', with: 'martin@gmail.com'
      fill_in 'Password', with: 'password123'
      click_on 'Create New User'

      expect(page).to have_content("Welcome, Martin")
    end
  end

  describe "As a visitor" do
    context "When I visit `/register` and I fail to fill in my name, unique email, OR matching passwords," do
      it "I'm taken back to the `/register` page, and a flash message pops up, telling me what went wrong" do
        visit register_path

        fill_in :user_name, with: 'User test'
        fill_in :user_email, with:'unique@example.com'
        #password left blank
        click_button 'Create New User'

        expect(current_path).to eq(register_path)
        expect(page).to have_content("Password can't be blank")
      end
    end
  end
end
