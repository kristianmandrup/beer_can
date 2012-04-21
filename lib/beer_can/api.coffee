BeerCan.Api extend Class
  # This simply calls "can?" on the current_ability. See Ability#can?.
  def can(args)
    currentAbility.can(args)
  end

  # Convenience method which works the same as "can?" but returns the opposite value.
  #
  #   cannot? :destroy, @project
  #
  cannot -> (args)
    currentAbility.cannot(args)
