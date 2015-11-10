require 'rails_helper'

feature 'creating a playlist' do
  before do
    OmniAuth.config.test_mode = true
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
    mock_omniauth_hash
    # OmniAuth.config.mock_auth[:spotify] = nil
    # OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
    #   :provider => 'spotify',
    #   :id => 'testing',
    #   :email => 'testing@testing.com'
    # })
  end

  context 'on /artists/playlist page' do
    scenario 'displays playlist recommendations' do
      visit '/'
      click_link 'Sign in to Grape with Spotify'
      user = User.find_by(username: 'test_username')
      user_2 = User.create(username: 'test_username_2')
      user_3 = User.create(username: 'test_username_3')
      artist = Artist.create(name: 'test_artist')
      user.artists << artist
      user_2.artists << artist
      recommended_user = double :user, id: 'test_username_2'
      allow(RSpotify::User).to receive(:find).and_return(recommended_user)
      recommended_artist = double :artist, first: 'test_artist'
      allow(RSpotify::Artist).to receive(:search).and_return(recommended_artist)
      click_link 'generate_playlist'
      expect(page).to have_content 'test_username_2'
      expect(page).to have_content 'test_artist'
      expect(current_path).to eq '/artists/playlist'
    end

    scenario 'can navigate to /users/index' do
      visit '/'
      click_link 'Sign in to Grape with Spotify'
      click_link 'generate_playlist'
      click_link 'welcome_logo'
      expect(current_path).to eq '/users/index'
    end
  end
end
