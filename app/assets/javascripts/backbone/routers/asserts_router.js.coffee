class Sam2.Routers.AssertsRouter extends Backbone.Router
  initialize: (options) ->
    @asserts = new Sam2.Collections.AssertsCollection()
    @asserts.reset options.asserts

  routes:
    "new"      : "newAssert"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAssert: ->
    @view = new Sam2.Views.Asserts.NewView(collection: @asserts)
    $("#asserts").html(@view.render().el)

  index: ->
    @view = new Sam2.Views.Asserts.IndexView(asserts: @asserts)
    $("#asserts").html(@view.render().el)

  show: (id) ->
    assert = @asserts.get(id)

    @view = new Sam2.Views.Asserts.ShowView(model: assert)
    $("#asserts").html(@view.render().el)

  edit: (id) ->
    assert = @asserts.get(id)

    @view = new Sam2.Views.Asserts.EditView(model: assert)
    $("#asserts").html(@view.render().el)
