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

  # Recommend artists
  # who appear in recommended user's but not current user's playlists,
  # ranked by number of appearance in the recommended user's account
  # capped at 10 recommended artists
  def recommend_artists(user)
    user[0].artists(:a).
      order('rel1.artist_presence DESC').
      limit(20).
      pluck('a', 'count(*)', 'rel1')
  end
end
