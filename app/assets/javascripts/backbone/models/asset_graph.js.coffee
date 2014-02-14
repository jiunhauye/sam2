class Sam2.Models.AssetGraph extends Backbone.Model
  paramRoot: 'asset_graph'

  defaults:
    graph: null
    file: null

class Sam2.Collections.AssetGraphsCollection extends Backbone.Collection
  model: Sam2.Models.AssetGraph
  url: '/asset_graphs'
