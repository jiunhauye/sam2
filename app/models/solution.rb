class Solution < Neo4j::Rails::Model
  property :solutionLabel, :type => String , :index => fulltext
  property :description, :type => String , :index => fulltext
  has_n(:has).to(Asset)
  has_n(:belong).to(Domain)
end
