require 'rails_helper'

feature 'generating a playlist' do
  before(:each) do
    OmniAuth.config.test_mode = true
    # OmniAuth.config.mock_auth[:spotify] = nil
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
    mock_omniauth_hash
  end

  context 'on /artists/playlist page' do
    scenario 'can generate recommendations on users, artists and tracks' do
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

      recommended_user = double :spotify_user, id: 'test_username_2', display_name: 'test_username_2', images: [{'url'=>'test_user_2_url'}]
      recommended_artist = double :spotify_artist, name: 'test_artist_2', uri: 'test_artist_2_uri', genres: ['test_artist_genre']
      recommended_track = double :spotify_track, id: 001, name: 'test_track', uri: 'test_track_uri'

      allow(RSpotify::User).to receive(:find).and_return(recommended_user)
      allow(RSpotify::Artist).to receive(:search).and_return([recommended_artist])
      allow(RSpotify::Track).to receive(:find).and_return(recommended_track)
      allow(recommended_artist).to receive_message_chain(:albums, :first, :tracks, :shuffle, :first).and_return(recommended_track)
      allow(recommended_user).to receive(:saved_tracks?).and_return([nil])

      click_link 'generate_playlist'
      within '.panel-heading#heading00' do
        expect(page).to have_content 'test_track'
        expect(page).not_to have_content 'test_artist_1'
        expect(page).to have_content 'test_artist_2'
        expect(page).to have_content 'test_artist_genre'
      end
      within '#collapse00' do
        expect(page).to have_selector "iframe[src*='test_track_uri']"
        expect(page).to have_link 'Save Track'
        expect(page).to have_selector "iframe[src*='https://embed.spotify.com/follow/1/?uri=test_artist_2_uri']"
        expect(page).to have_link 'More from this artist'
      end
      expect(page).to have_content "This playlist was generated using test_username_2's Spotify"
      expect(page).to have_selector :css, "img[src*='test_user_2_url']"
      expect(page).to have_selector "iframe[src*='https://embed.spotify.com/follow/1/?uri=spotify:user:test_username_2&size=basic&theme=light']"
      expect(current_path).to eq '/artists/playlist'
    end

    scenario 'Can save a track' do
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

      recommended_user = double :spotify_user, id: 'test_username_2', display_name: 'test_username_2', images: [{'url'=>'test_user_2_url'}], save_tracks!: nil
      recommended_artist = double :spotify_artist, name: 'test_artist_2', uri: 'test_artist_2_uri', genres: ['test_artist_genre']
      recommended_track = double :spotify_track, id: 001, name: 'test_track', uri: 'test_track_uri'

      allow(RSpotify::User).to receive(:find).and_return(recommended_user)
      allow(RSpotify::Artist).to receive(:search).and_return([recommended_artist])
      allow(RSpotify::Track).to receive(:find).and_return(recommended_track)
      allow(recommended_artist).to receive_message_chain(:albums, :first, :tracks, :shuffle, :first).and_return(recommended_track)
      allow(recommended_user).to receive(:saved_tracks?).and_return([nil])

      click_link 'generate_playlist'
      within '#collapse00' do
        click_link 'Save Track'
      end
      expect(current_path).to eq '/artists/playlist'
      allow(recommended_user).to receive(:saved_tracks?).and_return([true])
      visit '/artists/playlist'
      within '#collapse00' do
        expect(page).not_to have_link 'Save Track'
        expect(page).to have_content 'Track already saved'
      end
    end

    scenario 'can navigate to /users/index' do
      visit '/'
      click_link 'Sign in to Grape with Spotify'
      click_link 'generate_playlist'
      click_link 'welcome_logo'
      expect(current_path).to eq '/users/index'
    end

    scenario 'can sign out from Grape' do
      visit '/'
      click_link 'Sign in to Grape with Spotify'
      click_link 'generate_playlist'
      click_link 'Sign out'
      expect(current_path).to eq '/users/index'
      expect(page).not_to have_content 'Welcome, test_display_name'
      expect(page).not_to have_selector :css, "img[src*='test_user_url']"
      expect(page).to have_link 'Sign in to Grape with Spotify'
      expect(page).to have_content 'Signed out from Grape successully. Please note you are still signed in to Spotify.'
      expect(current_path).to eq '/users/index'
    end
  end
end
