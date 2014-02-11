class Sam2.Routers.SolutionsRouter extends Backbone.Router
  initialize: (options) ->
    @solutions = new Sam2.Collections.SolutionsCollection()
    @solutions.reset options.solutions

  routes:
    "new"      : "newSolution"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newSolution: ->
    @view = new Sam2.Views.Solutions.NewView(collection: @solutions)
    $("#solutions").html(@view.render().el)

  index: ->
    @view = new Sam2.Views.Solutions.IndexView(solutions: @solutions)
    $("#solutions").html(@view.render().el)

  show: (id) ->
    solution = @solutions.get(id)

    @view = new Sam2.Views.Solutions.ShowView(model: solution)
    $("#solutions").html(@view.render().el)

  edit: (id) ->
    solution = @solutions.get(id)

    @view = new Sam2.Views.Solutions.EditView(model: solution)
    $("#solutions").html(@view.render().el)
