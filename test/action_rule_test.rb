require '../config'
  
describe 'Tower.Authorization.BeerCan.Ability', ->
	beforeEach ->
    @ability = {}
    @ability.extends BeerCan.Ability
    @actionRule = new BeerCan.ActionRule

  it "should ..", ->
    @actionRule # .

    expect(@actionRule).toBeTruthy()
