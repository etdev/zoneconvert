require "rails_helper"

RSpec.feature "User views their events" do
  scenario "successfully" do
    user = create(:user)
    event = create(:event, user: user)
    sign_in user
    visit user_path(user)
    expect(page).to have_content event.local_time
  end
end
