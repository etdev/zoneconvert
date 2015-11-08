require "rails_helper"
require "pry"
require "pry-byebug"

RSpec.feature "User adds new event" do

  before do
    visit root_path
  end

  def fill_in_data(remote_location, remote_time, local_location)
    fill_in "event[remote_location]", with: remote_location
    fill_in "event[remote_time]", with: remote_time
    fill_in "event[local_location]", with: local_location
  end

  context "During US Daylight Savings" do
    scenario "for Tokyo from LA" do
      fill_in_data("Tokyo, Japan", "10/08/2015 7:00 PM", "Los Angeles, CA")
      click_button "Calculate"
      expect(page).to have_content("2015-10-08 03:00:00 UTC in Los Angeles, CA")
    end

    scenario "for LA from Tokyo" do
      fill_in_data("Los Angeles, CA", "11/08/2015 2:00 AM", "Tokyo, Japan")
      click_button "Calculate"
      expect(page).to have_content("2015-11-08 19:00:00 UTC in Tokyo, Japan")
    end

    scenario "for Tokyo from New York" do
      fill_in_data("Tokyo, Japan", "11/08/2015 7:00 PM", "New York, USA")
      click_button "Calculate"
      expect(page).to have_content("2015-11-08 05:00:00 UTC in New York, USA")
    end

    scenario "for New York from Tokyo" do
      fill_in_data("New York, USA", "11/08/2015 5:00 AM", "Tokyo, Japan")
      click_button "Calculate"
      expect(page).to have_content("2015-11-08 19:00:00 UTC in Tokyo, Japan")
    end
  end

  context "Outside US Daylight Savings" do
    scenario "for Tokyo from LA" do
      fill_in_data("Tokyo, Japan", "11/08/2015 7:00 PM", "Los Angeles, CA")
      click_button "Calculate"
      expect(page).to have_content("2015-11-08 02:00:00 UTC in Los Angeles, CA")
    end

    scenario "for LA from Tokyo" do
      fill_in_data("Los Angeles, CA", "11/08/2015 2:00 AM", "Tokyo, Japan")
      click_button "Calculate"
      expect(page).to have_content("2015-11-08 19:00:00 UTC in Tokyo, Japan")
    end

    scenario "for Tokyo from New York" do
      fill_in_data("Tokyo, Japan", "11/08/2015 7:00 PM", "New York, USA")
      click_button "Calculate"
      expect(page).to have_content("2015-11-08 05:00:00 UTC in New York, USA")
    end

    scenario "for New York from Tokyo" do
      fill_in_data("New York, USA", "11/08/2015 5:00 AM", "Tokyo, Japan")
      click_button "Calculate"
      expect(page).to have_content("2015-11-08 19:00:00 UTC in Tokyo, Japan")
    end
  end

end
