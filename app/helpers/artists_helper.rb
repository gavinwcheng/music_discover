module ArtistsHelper
  def retrieve_spotify_users_and_artists(current_user, recommended_users)
    @recommended_spotify_users = Array.new
    @recommended_spotify_artists = Hash.new
    recommended_users.each do |recommended_user|
      @recommended_spotify_users << retrieve_spotify_user(recommended_user[0])
      @recommended_spotify_artists[recommended_user[0].username] = Array.new
      recommend_artists(current_user, recommended_user[0]).each do |artist|
        @recommended_spotify_artists[recommended_user[0].username] << retrieve_spotify_artist(artist).first if artist.name != ""
      end
    end
  end

  def artists_from_recommended_user(index)
    @recommended_spotify_artists[@recommended_spotify_users[index].id] if @recommended_spotify_users[index]
  end

  def find_random_track(artists, index)
    artists[index].albums.first.tracks.shuffle.first
  end
end
