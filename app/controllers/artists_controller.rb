class ArtistsController < ApplicationController
  include ArtistsHelper

  def match
    @user = session[:current_user]
  end

  def playlist
    @yooser = RSpotify::User.new(session[:current_user].to_hash)
    current_user = User.find_by(username: session[:current_user]['id'])
    recommended_users = recommend_users current_user
    overlapped_artists = identify_overlapped_artists current_user
    retrieve_info_from_spotify recommended_users, overlapped_artists
  end
end
