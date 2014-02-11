class Sam2.Routers.CommunitiesRouter extends Backbone.Router
  initialize: (options) ->
    @communities = new Sam2.Collections.CommunitiesCollection()
    @communities.reset options.communities

  routes:
    "new"      : "newCommunity"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newCommunity: ->
    @view = new Sam2.Views.Communities.NewView(collection: @communities)
    $("#communities").html(@view.render().el)

  index: ->
    @view = new Sam2.Views.Communities.IndexView(communities: @communities)
    $("#communities").html(@view.render().el)

  show: (id) ->
    community = @communities.get(id)

    @view = new Sam2.Views.Communities.ShowView(model: community)
    $("#communities").html(@view.render().el)

  edit: (id) ->
    community = @communities.get(id)

    @view = new Sam2.Views.Communities.EditView(model: community)
    $("#communities").html(@view.render().el)
