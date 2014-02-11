Sam2.Views.Asserts ||= {}

class Sam2.Views.Asserts.EditView extends Backbone.View
  template : JST["backbone/templates/asserts/edit"]

  events :
    "submit #edit-assert" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (assert) =>
        @model = assert
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
