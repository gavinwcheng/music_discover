module ArtistsHelper
  def identify_overlapped_artists(user)
    user.as(:u1).artists(:a).users(:u2).where('u2 <> u1').pluck('DISTINCT a')
  end

  def retrieve_info_from_spotify(users, overlapped_artists)
    initialize_instance_variables
    recommended_artists = Hash.new
    users.each do |user|
      retrieve_recommended_users_from_spotify(user)
      @recommended_spotify_artists[user[0].username] = Array.new
      recommended_artists[user[0].username] = recommend_artists(user)
      retrieve_recommended_artists_from_spotify(user, recommended_artists[user[0].username], overlapped_artists)
    end
  end

  def initialize_instance_variables
    @recommended_spotify_users = Array.new
    @recommended_spotify_artists = Hash.new
  end

  def retrieve_recommended_users_from_spotify(user)
    @recommended_spotify_users << retrieve_spotify_user(user[0])
  end

  def retrieve_recommended_artists_from_spotify(user, artists, overlapped_artists)
    artists.each do |artist|
      unless overlapped_artists.include?(artist) || @recommended_spotify_artists[user[0].username].length >= 20
        @recommended_spotify_artists[user[0].username] << retrieve_spotify_artist(artist[0]).first if artist[0].name != ""
      end
    end
  end

  def artists_array_from_user index
    @recommended_spotify_artists[@recommended_spotify_users[index].id] if @recommended_spotify_users[index]
  end

  def name_of_artist_from(artist_array, index)
    artist_array[index].name
  end

  def random_track_from(artist_array, index)
    artist_array[index].albums.first.tracks.shuffle.first
  end
end
