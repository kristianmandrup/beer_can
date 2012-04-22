# Most of Rule functionality is tested in Ability specs
describe 'BeerCan.Rule', ->
  beforeEach ->
  	@rule = new BeerCan.Rule(true, 'read', Integer)

  it "should ...", ->
    expect(@rule).toBeTrusy()

