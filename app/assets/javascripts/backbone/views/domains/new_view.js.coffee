Sam2.Views.Domains ||= {}

class Sam2.Views.Domains.NewView extends Backbone.View
  template: JST["backbone/templates/domains/new"]

  events:
    "submit #new-domain": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (domain) =>
        @model = domain
        window.location.hash = "/#{@model.id}"

      error: (domain, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
