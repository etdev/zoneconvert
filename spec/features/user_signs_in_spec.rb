require "rails_helper"
RSpec.feature "User signs in" do
  scenario "successfully" do
    user = create(:user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password_digest
    click_button "Sign in"
    expect(page).to have_content(user.email)
  end
end
