Sam2.Views.Solutions ||= {}

class Sam2.Views.Solutions.NewView extends Backbone.View
  template: JST["backbone/templates/solutions/new"]

  events:
    "submit #new-solution": "save"

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
      success: (solution) =>
        @model = solution
        window.location.hash = "/#{@model.id}"

      error: (solution, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
