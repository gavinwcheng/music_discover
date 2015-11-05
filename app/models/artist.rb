class Artist
  include Neo4j::ActiveNode
  property :name, type: String
  has_many :in, :users, origin: :artists
end
