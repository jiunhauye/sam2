Sam2.Views.Assets ||= {}

class Sam2.Views.Assets.IndexView extends Backbone.View
  template: JST["backbone/templates/assets/index"]

  initialize: () ->
    @options.assets.bind('reset', @addAll)

  addAll: () =>
    @options.assets.each(@addOne)

  addOne: (asset) =>
    view = new Sam2.Views.Assets.AssetView({model : asset})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(assets: @options.assets.toJSON() ))
    @addAll()

    return this
