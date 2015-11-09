class ArtistsController < ApplicationController
  include ArtistsHelper
  include RspotifyHelper
  include RecommendationHelper

  def match
  end

  def playlist
    @recommended_users = recommend_users(current_user)
    p ' '
    p @recommended_users.first[0].username
    p ' '
    overlapped_artists = identify_overlapped_artists(current_user)
    retrieve_info_from_spotify(@recommended_users, overlapped_artists)
  end

  def save_track
    current_spotify_user = retrieve_spotify_user(current_user)
    track = retrieve_spotify_track(params[:trackid])
    current_spotify_user.save_tracks!([track])
    redirect_to '/artists/playlist'
  end
end
