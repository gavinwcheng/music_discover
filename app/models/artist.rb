class Artist
  include Neo4j::ActiveNode

  property :name, type: String
  property :popularity, type: Integer
  has_many :in, :users, origin: :artists
end
