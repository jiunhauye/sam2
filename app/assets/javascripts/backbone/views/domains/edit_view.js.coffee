Sam2.Views.Domains ||= {}

class Sam2.Views.Domains.EditView extends Backbone.View
  template : JST["backbone/templates/domains/edit"]

  events :
    "submit #edit-domain" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (domain) =>
        @model = domain
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
