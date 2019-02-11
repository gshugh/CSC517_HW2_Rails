class Location < ApplicationRecord

  # Relationships
  has_many :start_ats, dependent: :destroy
  has_many :visits, dependent: :destroy
  has_many :tours, through: :start_ats, dependent: :destroy
  has_many :tours, through: :visits, dependent: :destroy

  # Validations
  validates :country, presence: true
  validates :state, presence: true

  # Method to get a user-friendly string describing the location
  def user_friendly_description
    return state + ", " + country
  end

end
