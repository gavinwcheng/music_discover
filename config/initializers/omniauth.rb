require 'rspotify/oauth'


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, '432344e2c5ca400985abfe9cd67b7970', ENV['SPOTIFY_SECRET'], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
