################################################################################
# This is an RSpec for testing the booking model. It tests that a booking can
# be created, that the number of seats is a non-negative number, and that the
# table belongs to a user and/or a tour.
#
# This spec assumes that the following gems are installed.
#
# rspec-rails: https://github.com/rspec/rspec-rails
# Shoulda-matchers: https://github.com/thoughtbot/shoulda-matchers
# shoulda-callback-matchers: https://github.com/beatrichartz/shoulda-callback-matchers

require 'rails_helper'

RSpec.describe Booking, type: :model do

  describe "model" do

    it "should have a valid factory"

    # Lazily loaded to ensure it's only used when it's needed
    # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
    let(:booking) { Booking.new }

    context "with some number of seats" do
      it "should be valid with 1 seat"
      it "should be valid with 0 seats"
      it "should be invalid with -1 seats"
      it "should be invalid with 1.2 seats"
    end

    describe "associations" do
      it { should belong_to :user }
      it { should belong_to :tour }
    end

    test "test number of available seats" do
      assert_equal 9, Booking.get_available_seats_for_tour(@tour_1)
      assert_equal 18, Booking.get_available_seats_for_tour(@tour_2)
    end

  end
end
