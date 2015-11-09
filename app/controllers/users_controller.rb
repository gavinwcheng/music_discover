class UsersController < ApplicationController
  include UsersHelper
  include RspotifyHelper

  def index

  end

  def sync_profile
    current_spotify_user = instantiate_spotify_user(request.env['omniauth.auth'])
    current_database_user = User.merge(username: current_spotify_user.id, email: current_spotify_user.email)
    current_database_user.image_url = current_spotify_user.images.first.url if current_spotify_user.images.first
    current_database_user.display_name = current_spotify_user.display_name if current_spotify_user.display_name
    current_database_user.save
    session[:user_id] = current_database_user.id
    save_artists(current_spotify_user, current_database_user)
    redirect_to '/artists/match'
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Signed out from Grape successully. Please note you are still signed in with Spotify.'
    redirect_to '/users/index'
  end
end
