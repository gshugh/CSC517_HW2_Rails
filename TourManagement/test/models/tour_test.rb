require 'test_helper'

class TourTest < ActiveSupport::TestCase

  setup do
    @tour_1 = tours(:one)
    @tour_2 = tours(:two)
    @tour_3 = tours(:three)
  end

  test "test user friendly status description" do
    assert_equal "Completed", @tour_1.status_description
    assert_equal "In Future", @tour_2.status_description
    assert_equal "Cancelled", @tour_3.status_description
  end

  test "test check for past tour" do
    assert @tour_1.in_the_past
    assert_not @tour_2.in_the_past
  end

end
