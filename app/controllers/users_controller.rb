class UsersController < ApplicationController
  include UsersHelper

  def index
  end

  def spotify
    session[:current_user] = RSpotify::User.new(request.env['omniauth.auth'])
    current_user = User.merge(username: session[:current_user].id, email: session[:current_user].email)
    save_artists session[:current_user], current_user
    redirect_to '/users/match'
  end

  def match
    @user = session[:current_user]
  end

  def show_playlist
    # user1 = User.find_by(username: session[:current_user].id)
    # user1.artists.each do |artist|
    #   artist.users.each do |user|
    #
    #   end
    # end
    @user = session[:current_user]
    @track1 = RSpotify::Track.find('2vX5WL7s6UdeQyweZEx7PP')
    @track2 = RSpotify::Track.find('22mek4IiqubGD9ctzxc69s')
  end
end
