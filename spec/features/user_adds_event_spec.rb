require "rails_helper"
require "pry"
require "pry-byebug"

RSpec.feature "User adds new event" do
  scenario "successfully" do
    visit root_path
    fill_in "event[remote_location]", with: "Tokyo, Japan"
    fill_in "event[remote_time]", with: "02/03/2015 2:29 PM"
    fill_in "event[local_location]", with: "Los Angeles, CA"
    click_button "Calculate"
    expect(page).to have_content("2015-02-02 21:29:00 +0000 in Los Angeles, CA")
  end
end
