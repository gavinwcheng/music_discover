require 'rails_helper'
include UsersHelper

RSpec.describe RecommendationHelper, type: :helper do
  before(:each) do
    # ListensTo.where(from_node: user_2, to_node: artist_1).increment_artist_presence
  end

  it 'does not recommend user if only one user exists in database' do
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
    save_association(user_3, artist_1)
    save_association(user_3, artist_1)
    save_association(user_4, artist_1)
    save_association(user_5, artist_1)
    expect(recommend_users(user_1)).to eq([[user_2, 1, 3], [user_3, 1, 2], [user_4, 1, 1]])
  end

  
end
