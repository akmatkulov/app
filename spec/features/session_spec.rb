require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  fixtures :all

  scenario "login with invalid information" do
    visit root_path
    fill_in "session_email", with: "mike@albuqerke.com"
    fill_in "session_password", with: "foobar"
    click_button 'Войти'
    expect(page).to have_content('Invalid email/password')
  end

  scenario "login with valid information" do
    @user = user(:marko)
    visit root_path
    fill_in "session_email", with: @user.email
    fill_in "session_password", with: "supersecret"
    click_button 'Войти'
    expect(page).to have_content('You are logged in')
  end

  scenario "logout user after login" do
    @user = user(:marko)
    visit root_path
    fill_in "session_email", with: @user.email
    fill_in "session_password", with: "supersecret"
    click_button 'Войти'
    expect(page).to have_content('You are logged in')
    click_link('Logout')
    expect(page).to have_button("Войти")
    expect(page).not_to have_link("Logout")
  end
end
