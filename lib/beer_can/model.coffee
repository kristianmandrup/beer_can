BeerCan.ModelMixin extend Class
  # Here only the articles which the user can update are returned.
  accessible_by -> (ability, action = 'index')
    ability.execute self, action

  # fill up the model with an Authorization context
	cans -> (context)
		@authContext = context
		@ extend BeerCan.Api