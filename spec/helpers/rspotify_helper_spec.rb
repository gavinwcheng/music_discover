require 'rails_helper'

RSpec.describe RspotifyHelper, type: :helper do
  it 'instantiates a RSpotify user' do
    spotify_user = double :spotify_user
    allow(RSpotify::User).to receive(:new).with(:omniauth_params).and_return(spotify_user)
    expect(instantiate_spotify_user(:omniauth_params)).to eq(spotify_user)
  end

  it 'retrieves a RSpotify user' do
    spotify_user = double :spotify_user
    user = double :database_user, username: :test_username
    allow(RSpotify::User).to receive(:find).with(:test_username).and_return(spotify_user)
    expect(retrieve_spotify_user(user)).to eq(spotify_user)
  end

  it 'retrieves a RSpotify artist' do
    spotify_artist = double :spotify_artist
    artist = double :database_artist, name: :test_artist_name
    allow(RSpotify::Artist).to receive(:search).with(:test_artist_name).and_return(spotify_artist)
    expect(retrieve_spotify_artist(artist)).to eq(spotify_artist)
  end

  it 'retrieve a RSpotify track' do
    spotify_track = double :spotify_track
    allow(RSpotify::Track).to receive(:find).with(:test_track_id).and_return(spotify_track)
    expect(retrieve_spotify_track(:test_track_id)).to eq(spotify_track)
  end
end
