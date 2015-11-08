module RspotifyHelper
  def instantiate_spotify_user(omniauth_params)
    RSpotify::User.new(omniauth_params)
  end

  def retrieve_spotify_user(user)
    RSpotify::User.find(user.username)
  end

  def retrieve_spotify_artist(artist)
    RSpotify::Artist.search(artist.name)
  end

  def retrieve_spotify_track(track)
    RSpotify::Track.find(track)
  end
end
