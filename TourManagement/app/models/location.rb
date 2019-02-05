class Location < ApplicationRecord

  has_many :starts, dependent: :destroy
  has_many :visits, dependent: :destroy

  has_many :tours, through: :starts, dependent: :destroy
  has_many :tours, through: :visits, dependent: :destroy

  validates :country, presence: true
  validates :state, presence: true

end
