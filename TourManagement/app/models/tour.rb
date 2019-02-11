class Tour < ApplicationRecord

  # Support all of the "through" relationships
  # Destroy dependents if a tour is destroyed to avoid foreign key exceptions
  has_many :reviews, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :visits, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :waitlists, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :start_ats, dependent: :destroy

  # Establish "through" relationships
  has_many :locations, through: :visits, dependent: :destroy
  has_many :users, through: :bookmarks, dependent: :destroy
  has_many :users, through: :bookings, dependent: :destroy
  has_many :users, through: :waitlists, dependent: :destroy
  has_one :user, through: :listings, dependent: :destroy
  has_one :location, through: :start_ats, dependent: :destroy

  # Remove uniqueness validation for name, uniqueness is from the ID
  validates :name, presence: true
  validates :description, presence: true
  validates :price_in_cents, presence: true
  validates :deadline, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :operator_contact, presence: true
  validates :status, presence: true
  validates :num_seats, presence: true

end
