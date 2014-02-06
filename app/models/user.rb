class User < Neo4j::Rails::Model
  property :name, :type => String, :index => :fulltext
  has_n(:own).to(Assert)
end
