Sam2.Views.Asserts ||= {}

class Sam2.Views.Asserts.ShowView extends Backbone.View
  template: JST["backbone/templates/asserts/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
