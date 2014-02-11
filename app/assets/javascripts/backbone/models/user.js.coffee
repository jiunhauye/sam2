class Sam2.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    name: null

class Sam2.Collections.UsersCollection extends Backbone.Collection
  model: Sam2.Models.User
  url: '/users'
