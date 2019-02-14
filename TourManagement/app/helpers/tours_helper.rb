module ToursHelper

  # Method to determine if the given location is one selected by the user in search filtering
  def user_selected_location?(location)
    if flash[:filters].length.positive? && flash[:filters][:desired_location.to_s]
      return flash[:filters][:desired_location.to_s].to_i == location.id
    else
      return false
    end
  end

  # Method to determine the maximum price previously selected by the user in search filtering
  def user_selected_maximum_price
    if flash[:filters].length.positive? && flash[:filters][:max_price_dollars.to_s]
      return flash[:filters][:max_price_dollars.to_s].to_f
    else
      return ""
    end
  end

end
