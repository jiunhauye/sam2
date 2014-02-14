Sam2.Views.Assets ||= {}

class Sam2.Views.Assets.EditView extends Backbone.View
  template : JST["backbone/templates/assets/edit"]

  events :
    "submit #edit-asset" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (asset) =>
        @model = asset
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
