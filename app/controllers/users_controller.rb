class UsersController < ApplicationController
  def index
  end

  def spotify
   @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
   session[:spotify_user] = @spotify_user
   user = User.create(username: session[:spotify_user]["id"], email: session[:spotify_user]["email"])
   redirect_to '/users/match'
  end

  def match
    @user = session[:spotify_user]
  end

  def show_playlist #matching up users and showing songs from the other users's library
    @user = session[:user]
  end

end
