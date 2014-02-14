class AssetGraph < Neo4j::Rails::Model
  property :graph, :type => String
  property :file, :type => String

end
