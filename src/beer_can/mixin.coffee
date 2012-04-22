class BeerCan.Mixin extends BeerCan.Api
  currentAbility: ->
    @currentAbility = BeerCan.Ability.new(defaultCanSubject)

  defaultCanSubject: -> 
    currentUser
  
