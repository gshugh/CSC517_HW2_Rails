class User < ApplicationRecord

  # Define straightforward one-to-many relationship with reviews
  has_many :reviews, dependent: :destroy

  # Define intermediate relationships, needed to support "through" concept below
  has_many :listings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :waitlists, dependent: :destroy

  # Define has-many-through relationships, and what to do if dependent record goes away
  has_many :tours, through: :listings, dependent: :destroy
  has_many :tours, through: :bookmarks, dependent: :destroy
  has_many :tours, through: :bookings, dependent: :destroy
  has_many :tours, through: :waitlists, dependent: :destroy

  # Define validations, name does not need to be present
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
#  validates :name, presence: true
  # Do NOT validate presence of boolean fields (admin / agent / customer)
  # Seems to see false as not-present
  # We should make sure that unless a user has admin TRUE it cannot act as admin
  # That is, lack of value should be interpreted as FALSE by our application logic

end
