class Community < Neo4j::Rails::Model
  property :name, :type => String
  def as_json(options={})
    super(options || {})["community"].merge({:id => self.neo_id})
  end
end
