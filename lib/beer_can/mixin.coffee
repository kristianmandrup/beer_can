BeerCan.Mixin extend BeerCan.Api
  currentAbility ->
    @currentAbility = Tower.Authorization.BeerCan.Ability.new(defaultCanSubject)

  defaultCanSubject -> 
    currentUser
  
