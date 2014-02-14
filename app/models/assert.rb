class Assert < Neo4j::Rails::Model    
 

  property :assertName, :type => String , :index => :fulltext
  property :community, :type => String , :index => :fulltext
  property :shortDescription, :type => String , :index => :fulltext
  property :version, :type => Fixnum
  property :state, :type => String , :index => :fulltext
  has_n(:compose).to(Assert)
  has_n(:include).to(Assert)
  has_n(:aggregate).to(Assert)
  has_n(:depend).to(Assert)
  has_n(:use).to(Assert)
  has_n(:support).to(Assert)
  has_n(:realize).to(Assert)
  has_n(:implement).to(Assert)
  has_n(:refer).to(Assert)
  
  def as_json(options={})
    super(options || {})["assert"].merge({:id => self.neo_id})
  end
 
end