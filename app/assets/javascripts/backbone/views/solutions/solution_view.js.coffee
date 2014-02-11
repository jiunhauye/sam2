Sam2.Views.Solutions ||= {}

class Sam2.Views.Solutions.SolutionView extends Backbone.View
  template: JST["backbone/templates/solutions/solution"]

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
