module UsersHelper
  def save_users(spotify_user)
    database_user = User.merge(email: spotify_user.email, username: spotify_user.id)
    database_user.display_name = spotify_user.display_name if spotify_user.display_name
    database_user.image_url = spotify_user.images.first['url'] if spotify_user.images.first
    database_user.save
    database_user
  end

  def save_artists(spotify_user, database_user)
    spotify_user.playlists.each do |playlist|
      playlist.tracks.each do |track|
        track.artists.each do |artist|
          database_artist = Artist.merge(name: artist.name)
          database_artist.popularity = artist.popularity if artist.popularity
          database_artist.save
          save_association(database_user, database_artist)
        end
      end
    end
  end

  def save_association(user, artist)
    user.artists << artist unless user.artists.include?(artist)
  end
end
