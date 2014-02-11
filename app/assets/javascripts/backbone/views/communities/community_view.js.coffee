Sam2.Views.Communities ||= {}

class Sam2.Views.Communities.CommunityView extends Backbone.View
  template: JST["backbone/templates/communities/community"]

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
