# top level namespace
BeerCan = {}

require('.beer_can/rule')
require('.beer_can/ability')
require('.beer_can/api')
require('.beer_can/mixin')
require('.beer_can/model_mixin')

require('.beer_can/tower') if Tower

class BeerCan.RuleResult extends Boolean
	byThe: (relation) ->
		# ...
	byAny: (models) ->
		# ...

exports.BeerCan