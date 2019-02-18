require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  fixtures :bookmarks, :tours, :users

  describe "model" do

    it "should have a valid factory"

    # Lazily loaded to ensure it's only used when it's needed
    # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
    let(:bookmark) { Bookmark.new }

    describe "creation" do
      it "should be valid with a tour and a user"
      it "should be invalid without a tour"
      it "should be invalid without a user"
    end

    describe "associations" do
      it { should belong_to :user }
      it { should belong_to :tour }
    end

    describe "constraints" do
      it { should validate_uniqueness_of(:user_id).scoped_to(:tour_id) }
      it { should validate_uniqueness_of(:tour_id).scoped_to(:user_id) }
    end

  end

end
