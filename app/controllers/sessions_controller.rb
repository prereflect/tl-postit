class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have succesfully logged in!'
      redirect_to root_url
    else
      flash[:error] = 'Your username or password is incorrect.'
      redirect_to register_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have succesfully logged out!'
    redirect_to root_url
  end
end
