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
    @common_artists = current_user.as(:u1).artists(:a).users(:u2).where('u2 <> u1').pluck('DISTINCT a')

    @recommended_spotify_users = Array.new
    @favourite_artists = Hash.new
    @favourite_spotify_artists = Hash.new
    spotify_artists = Array.new

    @recommended_users.each do |user|
      i = 0
      @recommended_spotify_users << RSpotify::User.find(user[0].username)
      @favourite_artists[user[0].username] = user[0].artists(:a).order('a.popularity DESC').limit(30).pluck('a', 'count(*)')
      @favourite_artists[user[0].username].each do |artist|
        unless (@common_artists.include? artist) || (i >= 20)
          spotify_artists << RSpotify::Artist.search(artist[0].name).first if artist[0].name != ""
          i += 1
        end
      end
      @favourite_spotify_artists[user[0].username] = spotify_artists
      spotify_artists = []
    end
  end
end
