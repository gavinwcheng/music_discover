require 'rails_helper'

feature 'creating a playlist' do
  context 'on index page' do
    scenario 'displays a link to create playlist' do
      visit '/users/index'
      expect(page).to have_link 'Generate playlist'
    end
  end

  context 'clicking "Generate playlist" link on index page' do
    scenario 'displays playlist recommendations' do
      visit '/users/index'
      click_link 'Generate playlist'
      expect(page).to have_content ''
      expect(current_path).to eq '/users/playlist'
    end
  end
end
