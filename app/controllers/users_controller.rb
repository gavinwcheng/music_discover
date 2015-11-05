class UsersController < ApplicationController
  include UsersHelper

  def index
    @user = session[:current_user]
  end

  def spotify
    session[:current_user] = RSpotify::User.new(request.env['omniauth.auth'])
    current_user = User.merge(username: session[:current_user].id, email: session[:current_user].email)
    save_artists session[:current_user], current_user
    redirect_to '/users/match'
  end

  def match
    @user = session[:current_user]
  end

  def playlist
    current_user = User.find_by(username: session[:current_user]['id'])
    recommended_users = recommend_users current_user
    overlapped_artists = identify_overlapped_artists current_user
    retrieve_info_from_spotify recommended_users, overlapped_artists
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_url
  end
end
