module UsersHelper
  def save_artists user
    user.playlists.each do |playlist|
      playlist.tracks.each do |track|
        track.artists.each do |artist|
          Artist.merge(name: artist.name)
        end
      end
    end
  end
end
