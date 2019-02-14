class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  # # Method to get the bookmarks of the agent who created the given tour
  # def self.get_bookmarks_for_agent_for_tour(tour)
  #   if current_user_listed_given_tour?(tour)
  #
  #   matching_bookmarks = Bookmark.find_by(tour_id: tour.id)
  #   return matching_bookmarks
  #   # if matching_bookmarks
  #   #   matching_user_id = matching_listing.read_attribute("user_id")
  #   #   return matching_user_id
  #   # else
  #   #   return nil
  #   # end
  #   end
  # end
end
