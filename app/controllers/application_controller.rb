class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_time_zone

  def set_time_zone
    Time.zone = current_user.time_zone if current_user
  end

  helper_method :current_user, :logged_in?, :post_owner?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def post_owner?
    current_user == @post.creator
  end

  def require_user
    access_denied unless logged_in?
  end

  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end
  
  def access_denied
    flash[:error] = 'You are not allowed to perform that action.'
    redirect_to root_url
  end
end
