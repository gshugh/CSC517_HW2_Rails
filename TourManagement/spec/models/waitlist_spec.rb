################################################################################
# This is an RSpec for testing the waitlist model. It tests that a booking can
# be created, that the number of seats is a non-negative number, and that the
# table belongs to a user and/or a tour.
#
# This spec assumes that the following gems are installed.
#
# rspec-rails: https://github.com/rspec/rspec-rails
# Shoulda-matchers: https://github.com/thoughtbot/shoulda-matchers
# shoulda-callback-matchers: https://github.com/beatrichartz/shoulda-callback-matchers

require 'rails_helper'

RSpec.describe Waitlist, type: :model do
  describe "model" do

    it "has a valid factory" do
      expect(Waitlist.new.to be_valid)
    end

    # Lazily loaded to ensure it's only used when it's needed
    # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
    let(:waitlist) { Waitlist.new }

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

  end
end
