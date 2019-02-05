class Waitlist < ApplicationRecord

  belongs_to :user
  belongs_to :tour

  validates :num_seats, presence: true

end
