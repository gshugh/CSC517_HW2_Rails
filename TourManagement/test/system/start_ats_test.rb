require "application_system_test_case"

class StartAtsTest < ApplicationSystemTestCase
  setup do
    @start_at = start_ats(:one)
  end

  test "visiting the index" do
    visit start_ats_url
    assert_selector "h1", text: "Starts"
  end

  test "creating a Start" do
    visit start_ats_url
    click_on "New Start"

    fill_in "Location", with: @start_at.location_id
    fill_in "Tour", with: @start_at.tour_id
    click_on "Create Start"

    assert_text "Start was successfully created"
    click_on "Back"
  end

  test "updating a Start" do
    visit start_ats_url
    click_on "Edit", match: :first

    fill_in "Location", with: @start_at.location_id
    fill_in "Tour", with: @start_at.tour_id
    click_on "Update Start"

    assert_text "Start was successfully updated"
    click_on "Back"
  end

  test "destroying a Start" do
    visit start_ats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Start was successfully destroyed"
  end
end
