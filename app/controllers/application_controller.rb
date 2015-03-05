class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
    if !logged_in?
      flash[:error] = 'You must be logged in for this action'
      redirect_to root_url
    end
  end
end
