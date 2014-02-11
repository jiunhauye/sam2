class Sam2.Models.Domain extends Backbone.Model
  paramRoot: 'domain'

  defaults:
    name: null
    fullpath: null
    description: null

class Sam2.Collections.DomainsCollection extends Backbone.Collection
  model: Sam2.Models.Domain
  url: '/domains'
