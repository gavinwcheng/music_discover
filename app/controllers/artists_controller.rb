class ArtistsController < ApplicationController
  include ArtistsHelper
  include RspotifyHelper
  include RecommendationHelper

  def match
  end

  def playlist
    @yooser = retrieve_spotify_user(current_user)
    recommended_users = recommend_users(current_user)
    overlapped_artists = identify_overlapped_artists(current_user)
    retrieve_info_from_spotify(recommended_users, overlapped_artists)
  end
end
