require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "created new user with valid information" do
    visit signup_path
    fill_in "user_user_name", with: "mike88"
    fill_in "user_name", with: "Mike Ehrmantraut"
    fill_in "user_email", with: "mike@albuqerke.com"
    fill_in "user_password", with: "foobar"
    fill_in "user_password_confirmation", with: "foobar"
    click_button 'Create User'
    expect(page).to have_content('Please check your email to activate your account.')
  end
end
