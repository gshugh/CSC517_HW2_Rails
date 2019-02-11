class Review < ApplicationRecord

  # Relationships
  belongs_to :user
  belongs_to :tour

  # Validations
  validates :subject, presence: true
  validates :content, presence: true

  # Get user name from review
  def get_user_name
    User.find(user_id).read_attribute("name")
  end

  # Get tour name from review
  def get_tour_name
    Tour.find(tour_id).read_attribute("name")
  end

end
