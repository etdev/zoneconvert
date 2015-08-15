require "rails_helper"

RSpec.feature "User adds new event" do
  scenario "successfully" do
    visit new_event_path
    fill_in "event[remote_location]", with: "Tokyo, Japan"
    fill_in "event[remote_time]", with: "02/03/2015 2:29 PM"
    fill_in "event[local_location]", with: "Los Angeles, CA"
    click_button "Calculate"
    expect(page).to have_content("Success!")
  end
end
