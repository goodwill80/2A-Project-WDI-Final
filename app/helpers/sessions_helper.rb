module SessionsHelper

  def log_in(user)
      session[:user_id] = user.id
    end

    # Get current user from session id, always check from the latest session
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    # check if passed user is current_user
    def current_user?(user)
      user == current_user
    end

    # check if current user is nil
    def logged_in?
      current_user
    end

    def log_out
      session.delete(:user_id) #delete part of the session
      @current_user = nil #set current_user to empty again
    end
  end
