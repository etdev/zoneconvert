require "rails_helper"
require "pry"
require "pry-byebug"

RSpec.feature "User adds new event" do

  before do
    visit root_path
  end

  scenario "for Tokyo from LA" do
    fill_in "event[remote_location]", with: "Tokyo, Japan"
    fill_in "event[remote_time]", with: "11/08/2015 7:00 PM"
    fill_in "event[local_location]", with: "Los Angeles, CA"
    click_button "Calculate"
    expect(page).to have_content("2015-11-08 02:00:00 +0000 in Los Angeles, CA")
  end

  scenario "for LA from Tokyo" do
    fill_in "event[remote_location]", with: "Los Angeles, CA"
    fill_in "event[remote_time]", with: "11/08/2015 2:00 AM"
    fill_in "event[local_location]", with: "Tokyo, Japan"
    click_button "Calculate"
    expect(page).to have_content("2015-11-08 19:00:00 +0000 in Tokyo, Japan")
  end

  scenario "for Tokyo from New York" do
    fill_in "event[remote_location]", with: "Tokyo, Japan"
    fill_in "event[remote_time]", with: "11/08/2015 7:00 PM"
    fill_in "event[local_location]", with: "New York, USA"
    click_button "Calculate"
    expect(page).to have_content("2015-11-08 05:00:00 +0000 in New York, USA")
  end

  scenario "for New York from Tokyo" do
    fill_in "event[remote_location]", with: "New York, USA"
    fill_in "event[remote_time]", with: "11/08/2015 5:00 AM"
    fill_in "event[local_location]", with: "Tokyo, Japan"
    click_button "Calculate"
    expect(page).to have_content("2015-11-08 19:00:00 +0000 in Tokyo, Japan")
  end

end
