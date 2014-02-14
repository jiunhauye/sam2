class Asset < Neo4j::Rails::Model
  property :assetId, :type => String , :index => :fulltext
  property :assetName, :type => String , :index => :fulltext
  property :community, :type => String , :index => :fulltext
  property :shortDescription, :type => String , :index => :fulltext
  property :version, :type => Fixnum
  property :state, :type => String , :index => :fulltext
  property :assetType, :type => String , :index => :fulltext
  property :ownerId, :type => String , :index => :fulltext
  property :layer, :type => String , :index => :fulltext
  property :domainPath, :type => String , :index => :fulltext
  has_n(:AssociateWith) #associatedBy
  has_n(:Compose) #Composed by
  has_n(:Inherit) #Inherited by
  has_n(:Aggregate) #aggregatedBy
  has_n(:depend)
  has_n(:use)
  has_n(:support)
  has_n(:realize)
  has_n(:implement)
  has_n(:refer)
  has_n(:include)  
  # has_n(:AssociateWith).to(Asset) #associatedBy
  # has_n(:Compose).to(Asset) #Composed by
  # has_n(:Inherit).to(Asset) #Inherited by
  # has_n(:Aggregate).to(Asset) #aggregatedBy
  # has_n(:depend).to(Asset)
  # has_n(:use).to(Asset)
  # has_n(:support).to(Asset)
  # has_n(:realize).to(Asset)
  # has_n(:implement).to(Asset)
  # has_n(:refer).to(Asset)
  # has_n(:include).to(Asset)
  
  
  def as_json(options={})
    super(options || {})["asset"].merge({:id => self.neo_id})
  end




end
