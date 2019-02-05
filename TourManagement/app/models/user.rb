class User < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :waitlists, dependent: :destroy

  has_many :tours, through: :listings, dependent: :destroy
  has_many :tours, through: :bookmarks, dependent: :destroy
  has_many :tours, through: :bookings, dependent: :destroy
  has_many :tours, through: :waitlists, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :name, presence: true
  validates :admin, presence: true
  validates :agent, presence: true
  validates :customer, presence: true

end
