class Photo < ApplicationRecord

  # Relationships
  # https://evilmartians.com/chronicles/rails-5-2-active-storage-and-beyond
  belongs_to :tour
  has_one_attached :image

  # Validations
  validates :name, presence: true

end
