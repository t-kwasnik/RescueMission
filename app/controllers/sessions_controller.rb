class SessionsController < ApplicationController

  def create
    auth = env['omniauth.auth']
    user = User.find_or_create_from_omniauth(auth)
    set_current_user(user)
    flash[:notice] = "You're now signed in as #{user.username}!"

    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been signed out."
    redirect_to '/questions'
  end

end
