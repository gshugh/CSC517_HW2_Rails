module SessionsHelper

  # Some content from https://www.railstutorial.org/book/basic_login
  # Then added more methods as needed

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
  def current_user_listed_given_tour?(tour)
    matching_user_id = Listing.get_agent_id_for_tour(tour)
    return matching_user_id && current_user && matching_user_id == current_user.read_attribute("id")
  end

  # Method to determine if the current user is an admin
  def current_user_admin?
    return current_user && current_user.read_attribute("admin")
  end

  # Method to determine if the current user is an agent
  def current_user_agent?
    return current_user && current_user.read_attribute("agent")
  end

  # Method to determine if the current user is a customer
  def current_user_customer?
    return current_user && current_user.read_attribute("customer")
  end

  # Method to determine if the current user is allowed to create a tour
  def current_user_can_create_tour?
    return current_user_admin? || current_user_agent?
  end

  # Method to determine if the current user is allowed to edit / delete / cancel the given tour
  # Nobody can modify a tour that is completed
  # A tour in the future can always be modified by an admin
  # A tour in the future can be modified by an agent who has created the tour
  def current_user_can_modify_given_tour?(tour)
    can_modify =
      !tour.in_the_past &&
      (
        current_user_admin? ||
        (current_user_agent? && current_user_listed_given_tour?(tour))
      )
    return can_modify
  end

end
