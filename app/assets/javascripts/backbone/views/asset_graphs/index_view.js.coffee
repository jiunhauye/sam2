Sam2.Views.AssetGraphs ||= {}

class Sam2.Views.AssetGraphs.IndexView extends Backbone.View
  template: JST["backbone/templates/asset_graphs/index"]

  initialize: () ->
    @options.asset_graphs.bind('reset', @addAll)

  addAll: () =>
    @options.asset_graphs.each(@addOne)

  addOne: (assetGraph) =>
    view = new Sam2.Views.AssetGraphs.AssetGraphView({model : assetGraph})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(assetGraphs: @options.asset_graphs.toJSON() ))
    @addAll()

    return this
