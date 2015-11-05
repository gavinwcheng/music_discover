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

  def playlist
    current_user = User.find_by(username: session[:current_user]['id'])
    @recommended_users = current_user.as(:u1).artists.users(:u2).where('u2 <> u1').order('count(*) DESC').limit(10).pluck('u2', 'count(*)')

    @recommended_spotify_users = Array.new
    @recommended_users.each do |user|
      @recommended_spotify_users << RSpotify::User.find(user[0].username)
    end

    

    @common_artists = current_user.as(:u1).artists(:a).users(:u2).where('u2 <> u1').pluck('a')
  end
end
