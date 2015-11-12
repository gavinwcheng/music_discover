class ArtistsController < ApplicationController
  include ArtistsHelper
  include RspotifyHelper
  include RecommendationHelper

  def match
  end

  def playlist
    recommended_users = recommend_users(current_user)
    retrieve_spotify_users_and_artists(recommended_users)
  end

  def save_track
    current_spotify_user = retrieve_spotify_user(current_user)
    spotify_track = retrieve_spotify_track(params[:track_id])
    current_spotify_user.save_tracks!([spotify_track])
    redirect_to '/artists/playlist'
  end
end
