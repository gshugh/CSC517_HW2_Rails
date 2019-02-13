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
# factory_bot: https://github.com/thoughtbot/factory_bot

require 'rails_helper'

RSpec.describe Booking, type: :model do

  describe "model" do

    it "has a valid factory" do
      expect(build(:booking)).to be_valid
    end

    # Lazily loaded to ensure it's only used when it's needed
    # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
    let(:booking) { build(:booking) }

    describe "number of seat validations" do
      it { expect(build(:booking, :one_seat)).to(
          validate_numericality_of(:num_seats).is_greater_than_or_equal_to(0)) }
      it { expect(build(:booking, :zero_seats)).to(
          validate_numericality_of(:num_seats).is_greater_than_or_equal_to(0)) }
      it { expect(build(:booking, :negative_seats)).not_to be_valid }
      it { expect(build(:booking, :float_seats)).not_to be_valid }
    end

    it { should belong_to :user }
    it { should belong_to :tour }

  end
end
