Sam2.Views.AssetGraphs ||= {}

class Sam2.Views.AssetGraphs.AssetGraphView extends Backbone.View
  template: JST["backbone/templates/asset_graphs/asset_graph"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
