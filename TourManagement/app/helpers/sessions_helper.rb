module SessionsHelper

  # Content from https://www.railstutorial.org/book/basic_login

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Method to determine if the given tour was listed by the currently logged in user
  def tour_listed_by_current_user?(tour)
    matching_user_id = Listing.get_agent_id_for_tour(tour)
    return matching_user_id && current_user && matching_user_id == current_user.read_attribute("id")
  end

end
