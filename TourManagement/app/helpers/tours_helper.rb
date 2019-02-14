module ToursHelper

  # Method to determine if the given location is one selected by the user in search filtering
  def user_selected_location?(location)
    if flash[:filters].length.positive? && flash[:filters]["desired_location"]
      return flash[:filters]["desired_location"].to_i == location.id
    else
      return false
    end
  end
end
