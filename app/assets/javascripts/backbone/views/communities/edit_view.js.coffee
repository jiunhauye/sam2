Sam2.Views.Communities ||= {}

class Sam2.Views.Communities.EditView extends Backbone.View
  template : JST["backbone/templates/communities/edit"]

  events :
    "submit #edit-community" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (community) =>
        @model = community
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
