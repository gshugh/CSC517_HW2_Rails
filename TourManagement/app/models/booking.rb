################################################################################
# A booking is the number of seats from a particular tour that is reserved by a
# user.
#
# The number of seats must be a non-negative integer.

class Booking < ApplicationRecord

  # Relationships
  belongs_to :user
  belongs_to :tour

  # Validations
  validates :num_seats, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  # Method to get the number of booked seats for the given tour
  def self.get_booked_seats_for_tour(tour)
    num_booked_seats = 0
    bookings_for_tour = Booking.where(tour_id: tour.id)
    bookings_for_tour.each do |booking|
      num_booked_seats += booking.num_seats
    end
    return num_booked_seats
  end

  # Method to get the number of available seats for the given tour
  def self.get_available_seats_for_tour(tour)
    num_booked_seats = Booking.get_booked_seats_for_tour(tour)
    return tour.num_seats - num_booked_seats
  end

  # Method to get the waitlist created by this same user on this same tour
  # If no such waitlist, will return nil and we'll need to respond appropriately later on
  # TODO write a model test
  def waitlist_same_user_same_tour
    return Waitlist.where(user_id: user_id).find_by(tour_id: tour_id)
  end

end
