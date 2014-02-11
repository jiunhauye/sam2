Sam2.Views.Domains ||= {}

class Sam2.Views.Domains.IndexView extends Backbone.View
  template: JST["backbone/templates/domains/index"]

  initialize: () ->
    @options.domains.bind('reset', @addAll)

  addAll: () =>
    @options.domains.each(@addOne)

  addOne: (domain) =>
    view = new Sam2.Views.Domains.DomainView({model : domain})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(domains: @options.domains.toJSON() ))
    @addAll()

    return this
