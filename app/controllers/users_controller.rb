class UsersController < ApplicationController
  include UsersHelper

  def index
  end

  def spotify
    current_spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    current_database_user = User.merge(username: current_spotify_user.id, email: current_spotify_user.email)
    session[:user_id] = current_database_user.id
    save_artists current_spotify_user, current_database_user
    redirect_to '/artists/match'
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Signed out from Grape successully. Please note you are still signed in with Spotify.'
    redirect_to '/users/index'
  end
end
