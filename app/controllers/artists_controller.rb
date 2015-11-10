class ArtistsController < ApplicationController
  include ArtistsHelper
  include RspotifyHelper
  include RecommendationHelper

  def match
  end

  def playlist
    p '222'
    p current_user
    p current_user.artists.to_a
    @recommended_users = recommend_users(current_user)
    p '333'
    p @recommended_users
    overlapped_artists = identify_overlapped_artists(current_user)
    p '444'
    p overlapped_artists
    retrieve_info_from_spotify(@recommended_users, overlapped_artists)
    p '555'
    p @recommended_spotify_users
    p '666'
    p @recommended_spotify_artists
  end

  def save_track
    current_spotify_user = retrieve_spotify_user(current_user)
    track = retrieve_spotify_track(params[:trackid])
    current_spotify_user.save_tracks!([track])
    redirect_to '/artists/playlist'
  end
end
