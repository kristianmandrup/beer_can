class BeerCan.ActionRule # extends Class
  initialize: (actions) ->
    @actions = actions

  any: (model_classes) ->
    @model_classes = model_classes
    new BeerCan.Rule(@)

  the: (model) ->
    @model = model
    new Rule(@)

  all_the: (models) ->
    # ...
  any_of_the: (models) ->
    #