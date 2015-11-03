class User 
  include Neo4j::ActiveNode
  property :username, type: String
  property :email, type: String



end
