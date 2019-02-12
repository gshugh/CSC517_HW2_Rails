################################################################################
# This is a skeleton for testing models including examples of validations,
# callbacks, scopes, instance & class methods, associations, and more. Pick and
# choose what you want, as all models don't NEED to be tested at this depth.
#
# I'm always eager to hear new tips & suggestions as I'm still new to testing,
# so if you have any, please share!
#
# @kyletcarlson
#
# This skeleton also assumes you're using the following gems:
#
# rspec-rails: https://github.com/rspec/rspec-rails
# Shoulda-matchers: https://github.com/thoughtbot/shoulda-matchers
# shoulda-callback-matchers: https://github.com/beatrichartz/shoulda-callback-matchers
# factory_bot: https://github.com/thoughtbot/factory_bot

require 'rails_helper'

RSpec.describe Booking, type: :model do

  require 'spec_helper'

  describe "model" do

    it "has a valid factory" do
      # Using the shortened version of FactoryGirl syntax.
      # Add:  "config.include FactoryGirl::Syntax::Methods" (no quotes) to your spec_helper.rb
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
    end

    describe "table associations" do
      it { expect(:booking).to belong_to(:user) }
      it { expect(:booking).to belong_to(:tour) }
    end

  end
end
