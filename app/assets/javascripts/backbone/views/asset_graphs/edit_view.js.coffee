Sam2.Views.AssetGraphs ||= {}

class Sam2.Views.AssetGraphs.EditView extends Backbone.View
  template : JST["backbone/templates/asset_graphs/edit"]

  events :
    "submit #edit-asset_graph" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (asset_graph) =>
        @model = asset_graph
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
