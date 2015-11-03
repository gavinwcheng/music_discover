class UsersController < ApplicationController

  def index #saving the user and saving the user's artists
    User.create(username: "michael")
  end

  def show_playlist #matching up users and showing songs from the other users's library
    @user = User.first
  end
end
