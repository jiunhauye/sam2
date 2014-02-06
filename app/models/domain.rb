class Domain < Neo4j::Rails::Model
  property :name, :type => String, :index => :fulltext
  property :fullpath, :type => String, :index => :fulltext
  property :description, :type => String, :index => :fulltext

end
