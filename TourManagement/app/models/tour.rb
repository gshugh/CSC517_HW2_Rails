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
  validates :num_seats,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Do NOT validate presence of boolean fields (cancelled)
  # Seems to see false as not-present

  # Support filtering tours
  # https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  # https://guides.rubyonrails.org/active_record_querying.html#scopes
  # https://guides.rubyonrails.org/active_record_querying.html#joining-tables
  scope :desired_location, ->(desired_loc_id) {
    joins "INNER JOIN visits ON visits.tour_id = tours.id AND visits.location_id = #{desired_loc_id}"
  }
  # https://stackoverflow.com/questions/11317662/rails-using-greater-than-less-than-with-a-where-statement/23936233
  scope :max_price_dollars, ->(max_price_dollars) {
    where("price_in_cents <= ?", (max_price_dollars.to_f * 100).to_i)
  }

  # Calculate a description of the tour status
  def status_description
    return "Cancelled" if cancelled
    return "Completed" if in_the_past
    "In Future"
  end

  # Calculate whether the tour is in the past
  # If it is not a cancelled tour, this should make the status "Completed"
  def in_the_past
    Date.current >= end_date
  end

  def price_in_dollars
    price_in_cents/100.0 if !price_in_cents.nil?
  end

  def price_in_dollars=(val)
    self.price_in_cents = (val.to_f*100).to_int
  end


end
