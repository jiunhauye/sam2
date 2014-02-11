Sam2.Views.Domains ||= {}

class Sam2.Views.Domains.ShowView extends Backbone.View
  template: JST["backbone/templates/domains/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
