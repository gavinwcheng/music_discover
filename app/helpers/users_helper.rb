module UsersHelper
  def save_artists spotify_user, database_user
    spotify_user.playlists.each do |playlist|
      playlist.tracks.each do |track|
        track.artists.each do |artist|
          Artist.merge(name: artist.name)
          database_artist = Artist.find_by(name: artist.name)
          database_user.artists << database_artist unless database_user.artists.include? database_artist
        end
      end
    end
  end
end
