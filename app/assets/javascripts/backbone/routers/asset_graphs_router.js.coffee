class Sam2.Routers.AssetGraphsRouter extends Backbone.Router
  initialize: (options) ->
    @asset_graphs = new Sam2.Collections.AssetGraphsCollection()
    @asset_graphs.reset options.assetGraphs

  routes:
    "new"      : "newAssetGraph"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAssetGraph: ->
    @view = new Sam2.Views.AssetGraphs.NewView(collection: @asset_graphs)
    $("#asset_graphs").html(@view.render().el)

  index: ->
    @view = new Sam2.Views.AssetGraphs.IndexView(asset_graphs: @asset_graphs)
    $("#asset_graphs").html(@view.render().el)

  show: (id) ->
    asset_graph = @asset_graphs.get(id)

    @view = new Sam2.Views.AssetGraphs.ShowView(model: asset_graph)
    $("#asset_graphs").html(@view.render().el)

  edit: (id) ->
    asset_graph = @asset_graphs.get(id)

    @view = new Sam2.Views.AssetGraphs.EditView(model: asset_graph)
    $("#asset_graphs").html(@view.render().el)
