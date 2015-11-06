class ArtistsController < ApplicationController
  include ArtistsHelper

  def match
  end

  def playlist
    recommended_users = recommend_users current_user
    overlapped_artists = identify_overlapped_artists current_user
    retrieve_info_from_spotify recommended_users, overlapped_artists
  end
end
