require 'rails_helper'
include UsersHelper

RSpec.describe RecommendationHelper, type: :helper do
  before(:each) do
    # ListensTo.where(from_node: user_2, to_node: artist_1).increment_artist_presence
  end

  it 'does not recommend any user if only one user exists in database' do
    user_1 = User.create(username: 'test_username_1')
    artist_1 = Artist.create(name: 'test_artist_1')
    save_association(user_1, artist_1)
    expect(recommend_users(user_1)).to eq([])
  end

  it 'does not recommend user if no shared artist exists' do
    user_1 = User.create(username: 'test_username_1')
    user_2 = User.create(username: 'test_username_2')
    artist_1 = Artist.create(name: 'test_artist_1')
    save_association(user_1, artist_1)
    expect(recommend_users(user_1)).to eq([])
  end

  it 'recommends a user if shared artist exists' do
    user_1 = User.create(username: 'test_username_1')
    user_2 = User.create(username: 'test_username_2')
    artist_1 = Artist.create(name: 'test_artist_1')
    save_association(user_1, artist_1)
    save_association(user_2, artist_1)
    expect(recommend_users(user_1)).to eq([[user_2, 1, 1]])
  end

  it 'recommends users ranked by number of shared artists and number of appearance of each shared artist in the playlists of each user-pair' do
    user_1 = User.create(username: 'test_username_1')
    user_2 = User.create(username: 'test_username_2')
    user_3 = User.create(username: 'test_username_3')
    artist_1 = Artist.create(name: 'test_artist_1')
    artist_2 = Artist.create(name: 'test_artist_2')
    save_association(user_1, artist_1)
    save_association(user_1, artist_2)
    save_association(user_2, artist_1)
    save_association(user_2, artist_2)
    save_association(user_3, artist_1)
    expect(recommend_users(user_1)).to eq([[user_2, 2, 2], [user_3, 1, 1]])
  end

  it 'recommends a maximum of 3 users' do
    user_1 = User.create(username: 'test_username_1')
    user_2 = User.create(username: 'test_username_2')
    user_3 = User.create(username: 'test_username_3')
    user_4 = User.create(username: 'test_username_4')
    user_5 = User.create(username: 'test_username_5')
    artist_1 = Artist.create(name: 'test_artist_1')
    save_association(user_1, artist_1)
    save_association(user_2, artist_1)
    save_association(user_2, artist_1)
    save_association(user_2, artist_1)
    save_association(user_2, artist_1)
    save_association(user_3, artist_1)
    save_association(user_3, artist_1)
    save_association(user_3, artist_1)
    save_association(user_4, artist_1)
    save_association(user_4, artist_1)
    save_association(user_5, artist_1)
    expect(recommend_users(user_1)).to eq([[user_2, 1, 4], [user_3, 1, 3], [user_4, 1, 2]])
  end

  it 'does not recommend any artist from recommended user if all of them already exist in current user\'s playlists' do
    user_1 = User.create(username: 'test_username_1')
    user_2 = User.create(username: 'test_username_2')
    artist_1 = Artist.create(name: 'test_artist_1')
    save_association(user_1, artist_1)
    save_association(user_2, artist_1)
    expect(recommend_artists(user_1, user_2)).to eq([])
  end

  it 'only recommends artists from recommended user that are not in current user\'s playlists' do
    user_1 = User.create(username: 'test_username_1')
    user_2 = User.create(username: 'test_username_2')
    artist_1 = Artist.create(name: 'test_artist_1')
    artist_2 = Artist.create(name: 'test_artist_2')
    save_association(user_1, artist_1)
    save_association(user_2, artist_1)
    save_association(user_2, artist_2)
    expect(recommend_artists(user_1, user_2)).to eq([artist_2])
  end

  it 'recommends artists ranked by their number of appearance in the recommended user\'s playlists' do
    user_1 = User.create(username: 'test_username_1')
    user_2 = User.create(username: 'test_username_2')
    artist_1 = Artist.create(name: 'test_artist_1')
    artist_2 = Artist.create(name: 'test_artist_2')
    artist_3 = Artist.create(name: 'test_artist_3')
    save_association(user_1, artist_1)
    save_association(user_2, artist_1)
    save_association(user_2, artist_2)
    save_association(user_2, artist_2)
    save_association(user_2, artist_3)
    expect(recommend_artists(user_1, user_2)).to eq([artist_2, artist_3])
  end

  it 'recommends a maximum of 10 artists from each recommended user' do
    user_1 = User.create(username: 'test_username_1')
    user_2 = User.create(username: 'test_username_2')
    artists = Array.new
    12.times do |i|
      artist = Artist.create(name: "test_artist_#{i + 1}")
      artists << artist
    end
    save_association(user_1, artists[0])
    12.times do |j|
      (12-j).times do
        save_association(user_2, artists[j])
      end
    end
    expect(recommend_artists(user_1, user_2)).to eq([artists[1], artists[2], artists[3], artists[4], artists[5], artists[6], artists[7], artists[8], artists[9], artists[10]])
  end
end
