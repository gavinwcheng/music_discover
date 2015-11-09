class UsersController < ApplicationController
  include UsersHelper
  include RspotifyHelper

  def index
  end

  def sync_profile
    current_spotify_user = instantiate_spotify_user(request.env['omniauth.auth'])
    current_database_user = save_users(current_spotify_user)
    save_artists(current_spotify_user, current_database_user)
    session[:user_id] = current_database_user.id
    redirect_to '/artists/match'
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Signed out from Grape successully. Please note you are still signed in with Spotify.'
    redirect_to '/users/index'
  end
end
