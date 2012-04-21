# TODO

# Most of Rule functionality is tested in Ability specs
describe 'Tower.Authorization.BeerCan.Rule'
  beforeEach ->
  	@rule = new Tower.Authorization.BeerCan.Rule(true, 'read', Integer)

  it "should ...", ->
    expect(@rule).toBeTrusy()

