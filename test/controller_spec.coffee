# TODO

describe 'BeerCan.Controller', ->
	beforeEach ->
		@controller = new Tower.Authorization.BeerCan.Controller

  it "should have a current_ability method which generates an ability for the current user", ->
    expect(@controller.currentAbility).prototype.toEqual(Ability)

  it "should provide a can? and cannot? methods which go through the current ability", ->
    expect(@controller.currentAbility).prototype.toEqual(Ability)
    expect(@controller.can 'foo', 'bar').toBeFalsy()
    expect(@controller.cannot 'foo', 'bar').toBeTrusy()

