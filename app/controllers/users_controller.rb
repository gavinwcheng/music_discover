class UsersController < ApplicationController
  def index
  end

  def spotify
   @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
   session[:spotify_user] = @spotify_user
   redirect_to '/users/match'
  end

  def match
    @user = User.find_by(username: session[:spotify_user]['id'])
  end

  def show_playlist #matching up users and showing songs from the other users's library
    @user = User.first
    @spotify_user = session[:spotify_user]
  end

end
