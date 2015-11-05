module UsersHelper
  def save_artists spotify_user, database_user
    spotify_user.playlists.each do |playlist|
      playlist.tracks.each do |track|
        track.artists.each do |artist|
          database_artist = Artist.merge(name: artist.name)
          database_artist.popularity = artist.popularity if artist.popularity
          database_artist.save
          save_association database_user, database_artist
        end
      end
    end
  end

  def save_association user, artist
    user.artists << artist unless user.artists.include? artist
  end

  def recommend_users user
    user.as(:u1).artists.users(:u2).where('u2 <> u1').order('count(*) DESC').limit(10).pluck('u2', 'count(*)')
  end

  def identify_overlapped_artists user
    user.as(:u1).artists(:a).users(:u2).where('u2 <> u1').pluck('DISTINCT a')
  end

  def retrieve_info_from_spotify users, overlapped_artists
    initialize_instance_variables
    recommended_artists = Hash.new
    users.each do |user|
      retrieve_users_from_spotify user
      @recommended_spotify_artists[user[0].username] = Array.new
      recommended_artists[user[0].username] = recommend_artists user
      retrieve_artists_from_spotify user, recommended_artists[user[0].username], overlapped_artists
    end
  end

  def initialize_instance_variables
    @recommended_spotify_users = Array.new
    @recommended_spotify_artists = Hash.new
  end

  def retrieve_users_from_spotify user
    @recommended_spotify_users << RSpotify::User.find(user[0].username)
  end

  def recommend_artists user
    user[0].artists(:a).order('a.popularity DESC').limit(30).pluck('a', 'count(*)')
  end

  def retrieve_artists_from_spotify user, artists, overlapped_artists
    artists.each do |artist|
      unless (overlapped_artists.include? artist) || (@recommended_spotify_artists[user[0].username].length >= 20)
        @recommended_spotify_artists[user[0].username] << RSpotify::Artist.search(artist[0].name).first if artist[0].name != ""
      end
    end
  end
end
