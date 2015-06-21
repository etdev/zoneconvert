require "rails_helper"

RSpec.feature "User registers new account" do
  scenario "successfully" do
    visit root_path
    click_link "Sign up"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "test_password"
    click_button "Sign up"
    expect(page).to have_content("test@example.com")
    expect(page).to have_content("Account")
  end
end
