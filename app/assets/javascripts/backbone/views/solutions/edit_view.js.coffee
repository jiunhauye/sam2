Sam2.Views.Solutions ||= {}

class Sam2.Views.Solutions.EditView extends Backbone.View
  template : JST["backbone/templates/solutions/edit"]

  events :
    "submit #edit-solution" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (solution) =>
        @model = solution
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
