class Location < ApplicationRecord

  has_many :start_ats, dependent: :destroy
  has_many :visits, dependent: :destroy

  has_many :tours, through: :start_ats, dependent: :destroy
  has_many :tours, through: :visits, dependent: :destroy

  validates :country, presence: true
  validates :state, presence: true

end
