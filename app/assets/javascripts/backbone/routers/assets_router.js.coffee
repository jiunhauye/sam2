class Sam2.Routers.AssetsRouter extends Backbone.Router
  initialize: (options) ->
    @assets = new Sam2.Collections.AssetsCollection()
    @assets.reset options.assets

  routes:
    "new"      : "newAsset"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAsset: ->
    @view = new Sam2.Views.Assets.NewView(collection: @assets)
    $("#assets").html(@view.render().el)

  index: ->
    @view = new Sam2.Views.Assets.IndexView(assets: @assets)
    $("#assets").html(@view.render().el)

  show: (id) ->
    asset = @assets.get(id)

    @view = new Sam2.Views.Assets.ShowView(model: asset)
    $("#assets").html(@view.render().el)

  edit: (id) ->
    asset = @assets.get(id)

    @view = new Sam2.Views.Assets.EditView(model: asset)
    $("#assets").html(@view.render().el)
