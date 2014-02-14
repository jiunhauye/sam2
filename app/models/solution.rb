class Solution < Neo4j::Rails::Model
  property :solutionLabel, :type => String , :index => :fulltext
  property :description, :type => String , :index => :fulltext
  has_n(:has).to(Asset)
  has_n(:belong).to(Domain)
  def as_json(options={})
    # {:id => self.neo_id , :solutionLabel => self.solutionLabel , :description => self.description}
    #super(:include => [:neo_id])
    # puts "Start"
    # puts super((options || {}))
    # puts super((options || {})).merge({:solution => {:id => self.neo_id}})
    # puts "End"
    super((options || {}))[:solution].merge({:id => self.neo_id})
  end
end
