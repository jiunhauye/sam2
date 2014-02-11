Sam2.Views.Communities ||= {}

class Sam2.Views.Communities.ShowView extends Backbone.View
  template: JST["backbone/templates/communities/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
