Sam2.Views.Assets ||= {}

class Sam2.Views.Assets.AssetView extends Backbone.View
  template: JST["backbone/templates/assets/asset"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
