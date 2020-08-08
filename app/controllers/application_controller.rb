class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :logged_in?, :current_user, :set_user, :require_login

  def logged_in?
    !!session["user_id"]
  end

  def current_user
    User.find(session["user_id"])
  end

  def set_user
    @user = current_user
  end

  def require_login
    unless logged_in? 
        flash[:error] = "Please login to continue."
        redirect_to login_path
    end
  end
end
