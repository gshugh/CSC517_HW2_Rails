class Photo < ApplicationRecord

  belongs_to :tour

  validates :name, presence: true

end
