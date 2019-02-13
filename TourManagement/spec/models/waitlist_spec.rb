require 'rails_helper'

RSpec.describe Waitlist, type: :model do
  describe "model" do

    it "has a valid factory" do
      expect(build(:waitlist)).to be_valid
    end

    # Lazily loaded to ensure it's only used when it's needed
    # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
    let(:waitlist) { build(:waitlist) }

    describe "number of seat validations" do
      it { expect(build(:waitlist, :for_one_seat)).to(
          validate_numericality_of(:num_seats).is_greater_than_or_equal_to(0)) }
      it { expect(build(:waitlist, :for_zero_seats)).to(
          validate_numericality_of(:num_seats).is_greater_than_or_equal_to(0)) }
      it { expect(build(:waitlist, :for_negative_seats)).not_to be_valid }
      it { expect(build(:waitlist, :for_float_seats)).not_to be_valid }
    end

    it { should belong_to :user }
    it { should belong_to :tour }

  end
end
