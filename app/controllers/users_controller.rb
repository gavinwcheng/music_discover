class UsersController < ApplicationController
  def index #saving the user and saving the user's artists
    User.create(username: "michael")
  end

  def show_playlist #matching up users and showing songs from the other users's library
    @user = User.first
    @spotify_user = session[:spotify_user]
  end

  def spotify
   @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
   session[:spotify_user] = @spotify_user
   redirect_to '/users/playlist'
  end
end
