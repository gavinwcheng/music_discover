require 'rspotify/oauth'


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "b920e6b2cb564c88a2fa6b24229c22b3", ENV['SPOTIFY_SECRET'], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
