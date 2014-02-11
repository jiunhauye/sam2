Sam2.Views.Asserts ||= {}

class Sam2.Views.Asserts.IndexView extends Backbone.View
  template: JST["backbone/templates/asserts/index"]

  initialize: () ->
    @options.asserts.bind('reset', @addAll)

  addAll: () =>
    @options.asserts.each(@addOne)

  addOne: (assert) =>
    view = new Sam2.Views.Asserts.AssertView({model : assert})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(asserts: @options.asserts.toJSON() ))
    @addAll()

    return this
