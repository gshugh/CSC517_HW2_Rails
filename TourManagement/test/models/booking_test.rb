require 'test_helper'

class BookingTest < ActiveSupport::TestCase

  setup do
    @tour_1 = tours(:one)
    @tour_2 = tours(:two)
  end

  test "test number of available seats" do
    assert_equal 9, Booking.get_available_seats_for_tour(@tour_1)
    assert_equal 18, Booking.get_available_seats_for_tour(@tour_2)
  end

end
