class Sam2.Models.Asset extends Backbone.Model
  paramRoot: 'asset'

  defaults:
    assetName: null
    community: null
    shortDescription: null
    version: null
    state: null

class Sam2.Collections.AssetsCollection extends Backbone.Collection
  model: Sam2.Models.Asset
  url: '/assets'
