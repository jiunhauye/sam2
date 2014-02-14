Sam2.Views.Assets ||= {}

class Sam2.Views.Assets.NewView extends Backbone.View
  template: JST["backbone/templates/assets/new"]

  events:
    "submit #new-asset": "save"

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
      success: (asset) =>
        @model = asset
        window.location.hash = "/#{@model.id}"

      error: (asset, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
