class BeerCan.Api # extends Class
  # This simply calls "can?" on the current_ability. See Ability#can?.
  can: (args...) ->
    currentAbility.can args...

  # Convenience method which works the same as "can?" but returns the opposite value.
  #
  #   cannot? :destroy, @project
  #
  cannot: (args...) ->
    currentAbility.cannot args...
