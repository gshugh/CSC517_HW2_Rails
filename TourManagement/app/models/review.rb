class Review < ApplicationRecord

  belongs_to :user
  belongs_to :tour

  validates :subject, presence: true
  validates :content, presence: true

end
