class User < Neo4j::Rails::Model
  property :name, :type => String, :index => :fulltext
  has_n(:own).to(Asset)
  def as_json(options={})
    #puts super(options)
    super(options)["user"].merge({:id => self.neo_id})
  end
end
