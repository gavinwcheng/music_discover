module RecommendationHelper
  def recommend_users(user)
    user.as(:u1).artists.users(:u2).where('u2 <> u1').order('count(*) DESC').limit(2).pluck('u2', 'count(*)')
  end

  def recommend_artists(user)
    user[0].artists(:a).order('a.popularity DESC').limit(10).pluck('a', 'count(*)')
  end
end
