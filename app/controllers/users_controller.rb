class UsersController < ApplicationController
  include UsersHelper

  def index
    @user = session[:current_user]
  end

  def spotify
    session[:current_user] = RSpotify::User.new(request.env['omniauth.auth'])
    current_user = User.merge(username: session[:current_user].id, email: session[:current_user].email)
    save_artists session[:current_user], current_user
    redirect_to '/artists/match'
  end

  def destroy
    session[:current_user] = nil
    redirect_to '/users/index'
  end
end
