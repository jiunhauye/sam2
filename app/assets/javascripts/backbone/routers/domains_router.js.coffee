class Sam2.Routers.DomainsRouter extends Backbone.Router
  initialize: (options) ->
    @domains = new Sam2.Collections.DomainsCollection()
    @domains.reset options.domains

  routes:
    "new"      : "newDomain"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newDomain: ->
    @view = new Sam2.Views.Domains.NewView(collection: @domains)
    $("#domains").html(@view.render().el)

  index: ->
    @view = new Sam2.Views.Domains.IndexView(domains: @domains)
    $("#domains").html(@view.render().el)

  show: (id) ->
    domain = @domains.get(id)

    @view = new Sam2.Views.Domains.ShowView(model: domain)
    $("#domains").html(@view.render().el)

  edit: (id) ->
    domain = @domains.get(id)

    @view = new Sam2.Views.Domains.EditView(model: domain)
    $("#domains").html(@view.render().el)
