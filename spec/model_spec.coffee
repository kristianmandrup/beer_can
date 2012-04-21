# TODO

describe 'BeerCan.Model'
	@model = new Tower.Authorization.BeerCan.Model
	# configure

  it "should be accessible_by current user for reading"
    @model.accessible_by(currentUser, 'read').should be_true

  it "should not be accessible_by current user for writing"
    @model.accessible_by(currentUser, 'write').should be_false
