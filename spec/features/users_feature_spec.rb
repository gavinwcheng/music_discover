require 'rails_helper'

feature 'creating a playlist' do
  before do
    OmniAuth.config.test_mode = true
    mock_auth_hash
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
    # OmniAuth.config.mock_auth[:spotify] = nil
    # OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
    #   :provider => 'spotify',
    #   :id => 'testing',
    #   :email => 'testing@testing.com'
    # })
  end

  context 'on index page' do
    scenario 'can sign in with spotify account' do
      visit '/'
      expect(page).to have_link 'Sign in to Grape with Spotify'
      click_link 'Sign in to Grape with Spotify'
      expect(page).to have_content "Welcome testing"
      expect(page).to have_link 'Generate playlist'
      expect(current_path).to eq '/artists/match'
    end
  end

  context 'on match page' do
    xscenario 'displays playlist recommendations' do
      user = User.create(username: 'testing')
      user2 = User.create(username: 'testing2')
      user3 = User.create(username: 'testing3')
      artist = Artist.create(name: 'test_artist')
      user2.artists << artist
      visit '/'
      click_link 'Sign in to Grape with Spotify'
      click_link 'Generate playlist'
      expect(page).to have_content 'testing2'
      expect(page).to have_content 'test_artist'
      expect(current_path).to eq '/artists/playlist'
    end
  end
end
