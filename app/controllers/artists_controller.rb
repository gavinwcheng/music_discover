class ArtistsController < ApplicationController
  include ArtistsHelper
  include RspotifyHelper
  include RecommendationHelper

  def match
    @current_spotify_user = RSpotify::User.find(current_user.username)
  end

  def playlist
    @current_spotify_user = RSpotify::User.find(current_user.username)
    @recommended_users = recommend_users(current_user)
    p '   '
    p @recommended_users
    p '   '
    overlapped_artists = identify_overlapped_artists(current_user)
    retrieve_info_from_spotify(@recommended_users, overlapped_artists)
  end

  def save_track
    current_spotify_user = RSpotify::User.find(current_user.username)
    track = retrieve_spotify_track(params[:trackid])
    current_spotify_user.save_tracks!([track])
    redirect_to '/artists/playlist'
  end
end
