Sam2.Views.Solutions ||= {}

class Sam2.Views.Solutions.ShowView extends Backbone.View
  template: JST["backbone/templates/solutions/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
