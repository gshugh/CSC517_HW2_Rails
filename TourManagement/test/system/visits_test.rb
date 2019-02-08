require "application_system_test_case"

class VisitsTest < ApplicationSystemTestCase
  setup do
    @visit = visits(:one)
  end

  test "visiting the index" do
    visit visits_url
    assert_selector "h1", text: "Visits"
  end

  test "creating a Visit" do
    visit visits_url
    click_on "New Visit"

    fill_in "Location", with: @visit.location_id
    fill_in "Tour", with: @visit.tour_id
    click_on "Create Visit"

    assert_text "Visit was successfully created"
    click_on "Back"
  end

  test "updating a Visit" do
    visit visits_url
    click_on "Edit", match: :first

    fill_in "Location", with: @visit.location_id
    fill_in "Tour", with: @visit.tour_id
    click_on "Update Visit"

    assert_text "Visit was successfully updated"
    click_on "Back"
  end

  test "destroying a Visit" do
    visit visits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Visit was successfully destroyed"
  end
end
