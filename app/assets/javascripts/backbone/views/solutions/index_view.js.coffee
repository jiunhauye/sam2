Sam2.Views.Solutions ||= {}

class Sam2.Views.Solutions.IndexView extends Backbone.View
  template: JST["backbone/templates/solutions/index"]

  initialize: () ->
    @options.solutions.bind('reset', @addAll)

  addAll: () =>
    @options.solutions.each(@addOne)

  addOne: (solution) =>
    view = new Sam2.Views.Solutions.SolutionView({model : solution})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(solutions: @options.solutions.toJSON() ))
    @addAll()

    return this
