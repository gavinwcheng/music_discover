class User
  include Neo4j::ActiveNode

  property :email, type: String
  property :username, type: String
  property :display_name, type: String
  property :image_url, type: String

  has_many :out, :artists, rel_class: ListensTo
end
