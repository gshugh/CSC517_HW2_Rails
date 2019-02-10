module SessionsHelper

  # Content from https://www.railstutorial.org/book/basic_login

  def log_in(user)
    session[:user_id] = user.id
  end

end
