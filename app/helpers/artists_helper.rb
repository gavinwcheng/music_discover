module ArtistsHelper
  def retrieve_spotify_users_and_artists(users)
    @recommended_spotify_users = Array.new
    @recommended_spotify_artists = Hash.new
    users.each do |user|
      @recommended_spotify_users << retrieve_spotify_user(user[0])
      @recommended_spotify_artists[user[0].username] = Array.new
      recommend_artists(user).each do |artist|
          @recommended_spotify_artists[user[0].username] << retrieve_spotify_artist(artist[0])[0] if artist[0].name != ""
      end
    end
  end

  def artists_array_from_user(index)
    @recommended_spotify_artists[@recommended_spotify_users[index].id] if @recommended_spotify_users[index]
  end

  def name_of_artist_from(artist_array, index)
    artist_array[index].name
  end

  def uri_of_artist_from(artist_array, index)
    artist_array[index].uri
  end

  def random_track_from(artist_array, index)
    artist_array[index].albums.first.tracks.shuffle.first
  end
end
