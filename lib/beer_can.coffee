require('.beer_can/rule')
require('.beer_can/ability')
require('.beer_can/api')
require('.beer_can/mixin')

require('.beer_can/tower') if Tower

# top level namespace
BeerCan = {}

CanDo extends Boolean
	byThe -> (relation)
		# ...
	byAny -> (models)
		# ...


