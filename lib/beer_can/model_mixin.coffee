class BeerCan.ModelMixin # extends Class
  # Here only the articles which the user can update are returned.
  accessibleBy: (ability, action = 'index') ->
    ability.execute self, action

  # fill up the model with an Authorization context
	cans: (context) ->
		@authContext = context
		@ extends BeerCan.Api