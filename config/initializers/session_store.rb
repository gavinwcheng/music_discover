# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_music_discover_session'

MusicDiscover::Application.config.session_store :cookie_store,
  :key => '_my_session',
  :expire_after => 90.minutes
