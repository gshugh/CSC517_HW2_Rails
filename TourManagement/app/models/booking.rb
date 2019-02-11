################################################################################
# A booking is the number of seats from a particular tour that is reserved by a
# user.
#
# The number of seats must be a non-negative integer.

class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :tour

  validates :num_seats, presence: true,
                        numericality: {only_integer: true,
                                       greater_than_or_equal_to: 0}

end
