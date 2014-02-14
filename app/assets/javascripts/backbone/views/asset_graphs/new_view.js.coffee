Sam2.Views.AssetGraphs ||= {}

class Sam2.Views.AssetGraphs.NewView extends Backbone.View
  template: JST["backbone/templates/asset_graphs/new"]

  events:
    "submit #new-asset_graph": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (asset_graph) =>
        @model = asset_graph
        window.location.hash = "/#{@model.id}"

      error: (asset_graph, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
