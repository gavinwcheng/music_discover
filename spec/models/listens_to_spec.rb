require 'rails_helper'

RSpec.describe ListensTo, type: :model do
  it 'increments artist presence by 1' do
    user = User.create(username: 'test_username')
    artist = Artist.create(name: 'test_artist')
    listens_to = ListensTo.create(from_node: user, to_node: artist)
    expect{ listens_to.increment_artist_presence }.to change{ listens_to.artist_presence }.by(1)
    expect(listens_to.artist_presence).to eq(1)
  end

  it 'reset artist presence of a "LISTENS_TO" relationship' do
    user = User.create(username: 'test_username')
    artist = Artist.create(name: 'test_artist')
    listens_to = ListensTo.create(from_node: user, to_node: artist)
    listens_to.increment_artist_presence
    listens_to.reset_artist_presence
    expect(listens_to.artist_presence).to eq(0)
  end
end
