Sam2.Views.Domains ||= {}

class Sam2.Views.Domains.DomainView extends Backbone.View
  template: JST["backbone/templates/domains/domain"]

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
