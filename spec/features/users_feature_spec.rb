require 'rails_helper'

feature 'creating a playlist' do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:spotify] = nil
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      :provider => 'spotify',
      :id => 'testing',
      :email => 'testing@testing.com',
      :playlist => {
        :tracks => {
          :artists => {
            :name => 'test_artist'
          }
        }
      }
    })
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
  end

  context 'on index page' do
    scenario 'displays a link to create playlist' do
      user = User.create(username: 'testing')
      visit '/users/index'
      click_link 'Sign in with Spotify'
      expect(page).to have_content "Welcome #{user.username}"
      expect(page).to have_link 'Generate playlist'
      expect(current_path).to eq '/users/match'
    end
  end

  context 'on match page' do
    scenario 'displays playlist recommendations' do
      user = User.create(username: 'testing')
      user2 = User.create(username: 'testing2')
      user3 = User.create(username: 'testing3')
      artist = Artist.create(name: 'test_artist')
      user2.artists << artist
      visit '/users/index'
      click_link 'Sign in with Spotify'
      click_link 'Generate playlist'
      expect(page).to have_content 'testing2'
      expect(page).to have_content 'test_artist'
      expect(current_path).to eq '/users/playlist'
    end
  end
end
