Sam2.Views.Assets ||= {}

class Sam2.Views.Assets.ShowView extends Backbone.View
  template: JST["backbone/templates/assets/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
