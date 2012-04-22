class BeerCan.ActionRule # extends Class
  constructor: (actions) ->
    initialize(actions)

  initialize: (@actions) ->

  any: (@model_classes) ->
    new BeerCan.Rule(@)

  the: (@model) ->
    new Rule(@)

  all_the: (models) ->
    # ...
  any_of_the: (models) ->
    #