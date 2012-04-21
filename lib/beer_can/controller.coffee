Tower.Controller extend Tower.Authorization.BeerCan.Controller
  currentAbility ->
    @currentAbility = Tower.Authorization.BeerCan.Ability.new(current_user)

  # This simply calls "can?" on the current_ability. See Ability#can?.
  def can(args)
    currentAbility.can(*rgs)
  end

  # Convenience method which works the same as "can?" but returns the opposite value.
  #
  #   cannot? :destroy, @project
  #
  cannot -> (*args)
    currentAbility.cannot(args)
