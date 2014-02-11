class Sam2.Models.Community extends Backbone.Model
  paramRoot: 'community'

  defaults:
    name: null

class Sam2.Collections.CommunitiesCollection extends Backbone.Collection
  model: Sam2.Models.Community
  url: '/communities'
