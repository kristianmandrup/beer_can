console.log 'Drinking a Beer Can :)'

Array::remove = (e) -> @splice(t, 1)[0] if (t = @indexOf(e)) > -1

# top level namespace
BeerCan = {}

class BeerCan.RuleResult extends Boolean
	byThe: (relation) ->
		# ...
	byAny: (models) ->
		# ... 

module.exports = global.BeerCan = BeerCan = {};

require './beer_can/rule'
require './beer_can/ability'
require './beer_can/api'
require './beer_can/mixin'
require './beer_can/model_mixin'

require './beer_can/tower' if Tower?


