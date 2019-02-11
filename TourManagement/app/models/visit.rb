class Visit < ApplicationRecord

  # Relationships
  belongs_to :tour
  belongs_to :location

  # Get locations on the given tour's itinerary, in order
  def self.get_location_ids_for_tour(tour)
    Visit.where(tour_id: tour.id).order("location_id").map(&:location_id)
  end

  # Get the ith location id on the given tour's itinerary
  # Return -1 if there is no "ith" location on the given tour's itinerary
  def self.get_ith_location_id_for_tour(tour, i)
    tour_location_ids = get_location_ids_for_tour(tour)
    if tour_location_ids.length <= i
      return -1
    else
      return tour_location_ids[i]
    end
  end


end
