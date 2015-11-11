class ListensTo
  include Neo4j::ActiveRel

  from_class :User
  to_class :Artist

  property :artist_presence, type: Integer, default: 0

  def increment_artist_presence
    self.artist_presence += 1
    self.save
  end

  def reset_artist_presence
    self.artist_presence = 0
    self.save
  end
end
