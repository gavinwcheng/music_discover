require 'rails_helper'

feature 'creating a playlist' do
  before(:each) do
    OmniAuth.config.test_mode = true
    # OmniAuth.config.mock_auth[:spotify] = nil
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
    mock_omniauth_hash
  end

  context 'on /artists/playlist page' do
    scenario 'can see recommendations on users, artists and tracks' do
      visit '/'
      click_link 'Sign in to Grape with Spotify'

      user_1 = User.find_by(username: 'test_username')
      user_2 = User.create(username: 'test_username_2')
      user_3 = User.create(username: 'test_username_3')
      artist_1 = Artist.create(name: 'test_artist_1')
      artist_2 = Artist.create(name: 'test_artist_2')
      user_1.artists << artist_1
      user_2.artists << artist_1
      user_2.artists << artist_2

      recommended_user = double :spotify_user, id: 'test_username_2'
      recommended_artist = double :spotify_artist, name: 'test_artist_2', uri: 'test_artist_2_uri', genres: ['test_genre']
      recommended_track = double :spotify_track, id: 001, name: 'test_track', uri: 'test_track_uri'

      allow(RSpotify::User).to receive(:find).and_return(recommended_user)
      allow(RSpotify::Artist).to receive(:search).and_return([recommended_artist])
      allow(RSpotify::Track).to receive(:find).and_return(recommended_track)
      allow(recommended_artist).to receive_message_chain(:albums, :first, :tracks, :shuffle, :first).and_return(recommended_track)
      allow(recommended_user).to receive(:saved_tracks?).and_return([nil])

      click_link 'generate_playlist'
      expect(page).to have_content 'test_username_2'
      expect(page).not_to have_content 'test_artist_1'
      expect(page).to have_content 'test_artist_2'
      expect(page).to have_content 'test_track'
      expect(current_path).to eq '/artists/playlist'
    end

    scenario 'can navigate to /users/index' do
      visit '/'
      click_link 'Sign in to Grape with Spotify'

      user_1 = User.find_by(username: 'test_username')
      user_2 = User.create(username: 'test_username_2')
      artist_1 = Artist.create(name: 'test_artist_1')
      user_1.artists << artist_1
      user_2.artists << artist_1

      recommended_user = double :spotify_user, id: 'test_username_2'
      allow(RSpotify::User).to receive(:find).and_return(recommended_user)

      click_link 'generate_playlist'
      click_link 'welcome_logo'
      expect(current_path).to eq '/users/index'
    end
  end
end
