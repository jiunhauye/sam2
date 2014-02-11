Sam2.Views.Communities ||= {}

class Sam2.Views.Communities.NewView extends Backbone.View
  template: JST["backbone/templates/communities/new"]

  events:
    "submit #new-community": "save"

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
      success: (community) =>
        @model = community
        window.location.hash = "/#{@model.id}"

      error: (community, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
