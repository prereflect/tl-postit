class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]

  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      login_user!(user)
#      if user.two_factor_auth?
#        session[:two_factor] = true
#        user.generate_pin!
#        user.send_pin_to_twilio
#        redirect_to pin_url
#      else
#        login_user!(user)
#      end
    else
      flash[:error] = 'Your username or password is incorrect.'
      redirect_to register_url
    end
  end

#  def pin
#    access_denied if session[:two_factor].nil?
#
#    if request.post?
#      user = User.find_by pin: params[:pin]
#      if user
#        session[:two_factor] = nil
#        user.remove_pin!
#        login_user!(user)
#      else
#        flash[:error] = "Sorry, something is wrong with your pin number."
#        redirect_to pin_url
#      end
#    end
#  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have succesfully logged out!'
    redirect_to root_url
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = 'You have succesfully logged in!'
    redirect_to root_url
  end
end
