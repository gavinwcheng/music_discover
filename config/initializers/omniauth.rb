require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "b920e6b2cb564c88a2fa6b24229c22b3", "9168e4b3dd4841deb0862b7fb6d76dee", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
