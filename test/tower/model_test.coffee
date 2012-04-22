# TODO

describe 'BeerCan.Model', ->
	beforeEach ->
		@model = new Tower.Authorization.BeerCan.Model
	# configure

  it "should be accessible_by current user for reading", ->
    expect(@model.accessible_by currentUser, 'read').toBeTrusy()

  it "should not be accessible_by current user for writing", ->
    expect(@model.accessible_by currentUser, 'write').toBeFalsy()
