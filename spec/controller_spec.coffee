# TODO

describe 'BeerCan.Controller'
	@controller = new Tower.Authorization.BeerCan.Controller

  it "should have a current_ability method which generates an ability for the current user"
    @controller.currentAbility.should be_kind_of(Ability)

  it "should provide a can? and cannot? methods which go through the current ability"
    @controller.currentAbility.should be_kind_of(Ability)
    @controller.can('foo', 'bar').should be_false
    @controller.cannot('foo', 'bar').should be_true

