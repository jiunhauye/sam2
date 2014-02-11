class Sam2.Models.Assert extends Backbone.Model
  paramRoot: 'assert'

  defaults:
    assertName: null
    community: null
    shortDescription: null
    version: null
    state: null

class Sam2.Collections.AssertsCollection extends Backbone.Collection
  model: Sam2.Models.Assert
  url: '/asserts'
