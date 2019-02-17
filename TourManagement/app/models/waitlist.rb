################################################################################
# A waitlist is the number of seats on a particular tour that a user is
# waiting for.
#
# The number of seats must be a non-negative integer.

class Waitlist < ApplicationRecord

  # Relationships
  belongs_to :user
  belongs_to :tour

  # Validations
  validates :num_seats,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Method to get the booking created by this same user on this same tour
  # If no such booking, will return nil and we'll need to respond appropriately later on
  def booking_same_user_same_tour
    return Booking.where(user_id: user_id).find_by(tour_id: tour_id)
  end

end
