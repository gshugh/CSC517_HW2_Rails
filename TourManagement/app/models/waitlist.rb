################################################################################
# A waitlist is the number of seats on a particular tour that a user is
# waiting for.
#
# The number of seats must be a non-negative integer.

class Waitlist < ApplicationRecord

  belongs_to :user
  belongs_to :tour

  validates :num_seats, presence: true,
                        numericality: {only_integer: true,
                                       greater_than_or_equal_to: 0}

end
