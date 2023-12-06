class SessionsController < ApplicationController
    # login & logout actions should not require user to be logged in
    skip_before_filter :set_current_user  # check you version
    def create
      auth = request.env["omniauth.auth"]
      user =
        Moviegoer.where(provider: auth["provider"], uid: auth["uid"]) ||
        Moviegoer.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to movies_path
    end
    def destroy
      session.delete(:user_id)
      flash[:notice] = 'Logged out successfully.'
      redirect_to movies_path
    end
  end