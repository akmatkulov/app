require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  fixtures :all

  scenario "login with invalid information" do
    visit root_path
    fill_in "session_email", with: "mike@albuqerke.com"
    fill_in "session_password", with: "foobar"
    click_button 'Log in'
    expect(page).to have_content('Invalid email/password')
  end

  scenario "login with valid information" do
    @user = user(:marko)
    visit root_path
    fill_in "session_email", with: @user.email
    fill_in "session_password", with: "supersecret"
    click_button 'Log in'
    expect(page).to have_content('You are logged in')
  end

  scenario "successful edit with friendly forwarding" do
    @user = user(:marko)
    visit edit_user_path(@user)
    fill_in "session_email", with: @user.email
    fill_in "session_password", with: "supersecret"
    click_button 'Log in'
    expect(page).to have_content('Update your profile')
  end

  scenario "logout user after login" do
    @user = user(:marko)
    visit root_path
    fill_in "session_email", with: @user.email
    fill_in "session_password", with: "supersecret"
    click_button 'Log in'
    expect(page).to have_content('You are logged in')
    click_link('Logout')
    expect(page).to have_button("Log in")
    expect(page).not_to have_link("Logout")
  end
end
