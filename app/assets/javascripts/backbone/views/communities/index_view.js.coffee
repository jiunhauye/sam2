Sam2.Views.Communities ||= {}

class Sam2.Views.Communities.IndexView extends Backbone.View
  template: JST["backbone/templates/communities/index"]

  initialize: () ->
    @options.communities.bind('reset', @addAll)

  addAll: () =>
    @options.communities.each(@addOne)

  addOne: (community) =>
    view = new Sam2.Views.Communities.CommunityView({model : community})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(communities: @options.communities.toJSON() ))
    @addAll()

    return this
