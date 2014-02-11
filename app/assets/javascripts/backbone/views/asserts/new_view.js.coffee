Sam2.Views.Asserts ||= {}

class Sam2.Views.Asserts.NewView extends Backbone.View
  template: JST["backbone/templates/asserts/new"]

  events:
    "submit #new-assert": "save"

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
      success: (assert) =>
        @model = assert
        window.location.hash = "/#{@model.id}"

      error: (assert, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
