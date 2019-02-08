require "application_system_test_case"

class ToursTest < ApplicationSystemTestCase
  setup do
    @tour = tours(:one)
  end

  test "visiting the index" do
    visit tours_url
    assert_selector "h1", text: "Tours"
  end

  test "creating a Tour" do
    visit tours_url
    click_on "New Tour"

    fill_in "Deadline", with: @tour.deadline
    fill_in "Description", with: @tour.description
    fill_in "End date", with: @tour.end_date
    fill_in "Name", with: @tour.name
    fill_in "Num seats", with: @tour.num_seats
    fill_in "Operator contact", with: @tour.operator_contact
    fill_in "Price in cents", with: @tour.price_in_cents
    fill_in "Start date", with: @tour.start_date
    fill_in "Status", with: @tour.status
    click_on "Create Tour"

    assert_text "Tour was successfully created"
    click_on "Back"
  end

  test "updating a Tour" do
    visit tours_url
    click_on "Edit", match: :first

    fill_in "Deadline", with: @tour.deadline
    fill_in "Description", with: @tour.description
    fill_in "End date", with: @tour.end_date
    fill_in "Name", with: @tour.name
    fill_in "Num seats", with: @tour.num_seats
    fill_in "Operator contact", with: @tour.operator_contact
    fill_in "Price in cents", with: @tour.price_in_cents
    fill_in "Start date", with: @tour.start_date
    fill_in "Status", with: @tour.status
    click_on "Update Tour"

    assert_text "Tour was successfully updated"
    click_on "Back"
  end

  test "destroying a Tour" do
    visit tours_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tour was successfully destroyed"
  end
end
