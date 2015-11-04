class User
  include Neo4j::ActiveNode
  property :username, type: String
  property :email, type: String
  has_many :out, :artists, type: :LISTENS_TO
end
