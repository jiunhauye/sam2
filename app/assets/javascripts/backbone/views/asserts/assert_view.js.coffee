Sam2.Views.Asserts ||= {}

class Sam2.Views.Asserts.AssertView extends Backbone.View
  template: JST["backbone/templates/asserts/assert"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
