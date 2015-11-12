module RecommendationHelper
  # Recommend users
  # ranked by number of shared artists with current user and
  # number of appearance of each shared artist in both recommended user's and current user's playlists
  # capped at 3 recommended users
  def recommend_users(user)
    user.as(:u1).artists.users(:u2).
      where('u2 <> u1').
      order('sum(rel1.artist_presence) + sum(rel2.artist_presence) DESC').
      limit(3).
      pluck('u2', 'sum(rel1.artist_presence)', 'sum(rel2.artist_presence)')
  end

  # Recommend artists (from each recommended user above)
  # who appear in recommended user's but not current user's playlists,
  # ranked by number of appearance in the recommended user's account
  # capped at 10 recommended artists
  def recommend_artists(user)
    recommended_artists = Array.new
    artists = retrieve_favourite_artists(user[0])
    artists.each do |artist|
      unless user[0].artists.to_a.include?(artist) || recommended_artists.length >= 10
        recommended_artists << artist
      end
    end
    recommended_artists
  end

  private

  def retrieve_favourite_artists(user)
    user.artists(:a).
      order('rel1.artist_presence DESC').
      limit(20).
      pluck('a', 'count(*)', 'rel1')
  end
end
