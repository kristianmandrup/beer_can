Tower.Model extend Tower.Authorization.BeerCan.Model
    # Here only the articles which the user can update are returned.
    accessible_by -> (ability, action = 'index')
      ability.execute self, action
