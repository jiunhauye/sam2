Sam2.Views.Users ||= {}

class Sam2.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
