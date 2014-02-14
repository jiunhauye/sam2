Sam2.Views.AssetGraphs ||= {}

class Sam2.Views.AssetGraphs.ShowView extends Backbone.View
  template: JST["backbone/templates/asset_graphs/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
