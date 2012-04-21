require '../config'

# Most of Rule functionality is tested in Ability specs
describe 'BeerCan.Rule'
  beforeEach ->
  	@rule = new Tower.Authorization.BeerCan.Rule(true, 'read', Integer)

  it "should ...", ->
    expect(@rule).toBeTrusy()

